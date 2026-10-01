//
//  DownloadImageAsyncBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Shibili Areekara on 01/10/26.
//

import SwiftUI
import Combine

class DownloadImageAsyncImageLoader {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    private func handleReponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data, let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 100 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
    
    func downloadImageWithEscaping(completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let image = self?.handleReponse(data: data, response: response)
            completion(image, error)
        }
        .resume()
    }
    
    func dowloadImageWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleReponse)
            .mapError( { $0 } )
            .eraseToAnyPublisher()
    }
}

class DownloadImageAsyncViewModel: ObservableObject {
    
    @Published var image: UIImage?
    let imageLoader = DownloadImageAsyncImageLoader()
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchImage() {
        /*
        imageLoader.downloadImageWithEscaping { [weak self] image, _ in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
         */
        
        imageLoader.dowloadImageWithCombine()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] image in
                self?.image = image
            })
            .store(in: &cancellables)
    }
}

struct DownloadImageAsyncBootcamp: View {
    
    @StateObject private var vm = DownloadImageAsyncViewModel()
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 250, height: 250)
            }
        }
        .onAppear {
            vm.fetchImage()
        }
    }
}

#Preview {
    DownloadImageAsyncBootcamp()
}
