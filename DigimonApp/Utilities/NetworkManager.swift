//
//  NetworkManager.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/2/23.
//

import Foundation

protocol NetworkableProtocol {
    func makeGetRequest<T: Decodable>(url: URL, type: T.Type, _ completionHandler: @escaping (Result<T, Error>) -> Void)
}

class NetworkManager : NetworkableProtocol {
    static let shared = NetworkManager()
    
    init() {}
    
    func makeGetRequest<T>(url: URL, type: T.Type, _ completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                completionHandler(.failure(NetworkError.badUrlResponse(url: url)))
                return
            }
            
            guard let rawData = data else {
                completionHandler(.failure(NetworkError.unknown))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type, from: rawData)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}
