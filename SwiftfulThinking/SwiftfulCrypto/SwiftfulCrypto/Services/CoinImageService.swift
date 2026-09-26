//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 26/09/26.
//

import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage?
    private let coin: CoinModel
    var imageSubscription: AnyCancellable?
    
    private let fileManager = LocalFileManager.instance
    private let folderName = "coins_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            self.image = savedImage
            print("image retreived from file")
        } else {
            downloadCoinImage()
            print("downloading the image")
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(for: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedImage in
                guard let self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.save(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
