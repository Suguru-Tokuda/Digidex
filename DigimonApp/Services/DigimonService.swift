//
//  DigimonService.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/2/23.
//

import Foundation

class DigimonService {
    static let shared = DigimonService()
    
    init() {}
    
    func getDigimons(_ completionHandler: @escaping (Result<[Digimon], Error>) -> Void) {
        let urlStr = "\(Constants.apiBaseUrl)digimon"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(NetworkError.invalidURL(url: urlStr)))
            return
        }
        
        NetworkManager.shared.makeGetRequest(url: url, type: [Digimon].self) { res in
            switch res {
            case .success(let digimons):
                completionHandler(.success(digimons))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
