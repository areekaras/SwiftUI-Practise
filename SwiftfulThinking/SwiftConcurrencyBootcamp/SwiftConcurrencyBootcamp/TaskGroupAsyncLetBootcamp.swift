//
//  TaskGroupAsyncLetBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Shibili Areekara on 01/10/26.
//

import SwiftUI
import Combine

class TaskGroupAsyncLetImageManager {
    
    func downloadImageWithAsyncLet() async throws -> [UIImage] {
        async let asyncImage1 = fetchImage(from: "https://picsum.photos/300")
        async let asyncImage2 = fetchImage(from: "https://picsum.photos/300")
        async let asyncImage3 = fetchImage(from: "https://picsum.photos/300")
        async let asyncImage4 = fetchImage(from: "https://picsum.photos/300")
        async let asyncImage5 = fetchImage(from: "https://picsum.photos/300")
        
        async let asyncImage6 = fetchImage(from: "https://picsum.photos/300")
        async let asyncImage7 = fetchImage(from: "https://picsum.photos/300")
        async let asyncImage8 = fetchImage(from: "https://picsum.photos/300")
        async let asyncImage9 = fetchImage(from: "https://picsum.photos/300")
        
        return await [try asyncImage1, try asyncImage2, try asyncImage3, try asyncImage4, try asyncImage5, try asyncImage6, try asyncImage7, try asyncImage8, try asyncImage9]
    }
    
    func downloadImagesWithTaskGroup() async throws -> [UIImage] {
        
        return try await withThrowingTaskGroup(of: UIImage.self, returning: [UIImage].self) { group in
            var images = [UIImage]()
            
            group.addTask {
                try await self.fetchImage(from: "https://picsum.photos/300")
            }
            
            group.addTask {
                try await self.fetchImage(from: "https://picsum.photos/300")
            }
            
            group.addTask {
                try await self.fetchImage(from: "https://picsum.photos/300")
            }
            
            group.addTask {
                try await self.fetchImage(from: "https://picsum.photos/300")
            }
            
            group.addTask {
                try await self.fetchImage(from: "https://picsum.photos/300")
            }
            
            for try await image in group {
                images.append(image)
            }
            
            return images
        }
    }
    
    private func fetchImage(from urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.unknown)
            }
        } catch {
            throw error
        }
    }
}

class TaskGroupAsyncLetViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    
    private let manager = TaskGroupAsyncLetImageManager()
    
    func fetchImage() async {
        do {
            self.images = try await manager.downloadImagesWithTaskGroup()
        } catch {
            // handle error here
        }
    }
}

struct TaskGroupAsyncLetBootcamp: View {
    @StateObject private var vm = TaskGroupAsyncLetViewModel()
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(vm.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("AsyncLet&TaskGroup")
        }
        .task {
            await vm.fetchImage()
        }
    }
}

#Preview {
    TaskGroupAsyncLetBootcamp()
}
