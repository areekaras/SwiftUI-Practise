//
//  NetworkingManager.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 26/09/26.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingErrors: LocalizedError {
        case badServerResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badServerResponse(let url):
                return "[🔥] Bad response from url: \(url)"
            case .unknown:
                return "[⚠️] Unknown network error"
            }
        }
    }
    
    static func download(for url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try handleURLResponse(output: $0, url: url) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else {
            throw NetworkingErrors.badServerResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
