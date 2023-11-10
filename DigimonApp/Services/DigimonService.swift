//
//  DigimonService.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/2/23.
//

import Foundation

protocol DigimonsResponseProtocol : AnyObject {
    func didFinishWithResponse(digimons: [Digimon])
    func didFishWithError(error: Error)
}

final class DigimonService {
    static let shared = DigimonService()
    weak var delegate: DigimonsResponseProtocol?
    
    private init() {}
    
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
    
    func getDigimonsWithDelegate() -> Void {
        let urlStr = "\(Constants.apiBaseUrl)digimon"
        
        guard let url = URL(string: urlStr) else {
            self.delegate?.didFishWithError(error: NetworkError.invalidURL(url: urlStr))
            return
        }
        
        NetworkManager.shared.makeGetRequest(url: url, type: [Digimon].self) { res in
            switch res {
            case .success(let digimons):
                self.delegate?.didFinishWithResponse(digimons: digimons)
            case .failure(let error):
                self.delegate?.didFishWithError(error: error)
            }
        }
    }
    
    func processDigimons(digimons: [Digimon]) -> ([DigimonLevel : [Digimon]], [DigimonLevel]) {
        var digimonDict: [DigimonLevel : [Digimon]] = [:]
        var levels: [DigimonLevel] = []
        DigimonLevel.allCases.forEach({ digiLevel in
            let filteredDigimons = digimons.filter { $0.level == digiLevel.rawValue }
            if !filteredDigimons.isEmpty {
                digimonDict[digiLevel] = filteredDigimons.sorted(by: { $0.name < $1.name })
                levels.append(digiLevel)
            }
        })
        
        return (digimonDict, levels)
    }
}
