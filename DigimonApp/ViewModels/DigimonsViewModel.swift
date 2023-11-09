//
//  DigimonTableViewModel.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/9/23.
//

import Foundation

class DigimonsViewModel {
    var levels: [DigimonLevel] = []
    var digimonDict: [DigimonLevel : [Digimon]] = [:]
        
    var dataFetchCompletionHandler: (() -> ())?
    var dataFetchFailureHandler: ((Error) -> ())?
    
    func getDigimons() {
        DispatchQueue.global(qos: .utility).async {
            DigimonService.shared.getDigimons { [weak self] res in
                DispatchQueue.main.async {
                    switch res {
                    case .success(let digimons):
                        self?.processDigimons(digimons: digimons)
                        self?.dataFetchCompletionHandler?()
                    case .failure(let error):
                        self?.dataFetchFailureHandler?(error)
                    }
                }
            }
        }
    }
    
    func getDigimonsWithDelegate() {
        DispatchQueue.main.async {
            self.digimonDict = [:]
            self.levels = []
        }
        var digimonService: DigimonService? = DigimonService.shared
        digimonService?.delegate = self
        
        digimonService?.getDigimonsWithDelegate()
        digimonService = nil
    }

    private func processDigimons(digimons: [Digimon]) {
        let (digimonDict, levels) = DigimonService.shared.processDigimons(digimons: digimons)
        self.digimonDict = digimonDict
        self.levels = levels
    }
}

extension DigimonsViewModel: DigimonsResponseProtocol {
    func didFinishWithResponse(digimons: [Digimon]) {
        DispatchQueue.main.async {
            self.processDigimons(digimons: digimons)
            self.dataFetchCompletionHandler?()
        }
    }
    
    func didFishWithError(error: Error) {
        self.dataFetchFailureHandler?(error)
    }
}
