//
//  DigimonTableViewController.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/2/23.
//

import UIKit

class DigimonTableViewController: UIViewController {
    var levels: [DigimonLevel] = []
    var digimons: [Digimon] = []
    var digimonDict: [DigimonLevel : [Digimon]] = [:]
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DigimonTableViewCell.self, forCellReuseIdentifier: DigimonTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        getDigimons()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}

extension DigimonTableViewController {
    private func getDigimons() {
        DispatchQueue.global(qos: .utility).async {
            DigimonService.shared.getDigimons { res in
                DispatchQueue.main.async { [weak self] in
                    switch res {
                    case .success(let digimons):
                        self?.digimons = digimons
                        self?.processDigimons(digimons: digimons)
                        self?.tableView.reloadData()
                    case .failure(let error):
                        let alert = UIAlertController(title: "Error fetching digimon data.", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                        self?.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    private func processDigimons(digimons: [Digimon]) {
        self.digimonDict = [:]
        self.levels = []
        DigimonLevel.allCases.forEach({ digiLevel in
            let filteredDigimons = digimons.filter { $0.level == digiLevel.rawValue }
            if !filteredDigimons.isEmpty {
                digimonDict[digiLevel] = filteredDigimons.sorted(by: { $0.name < $1.name })
                levels.append(digiLevel)
            }
        })
    }
}

extension DigimonTableViewController {
    private func setUpUI() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension DigimonTableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let digimons = digimonDict[self.levels[section]] {
            return digimons.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DigimonTableViewCell.identifier, for: indexPath) as? DigimonTableViewCell else { return UITableViewCell() }
        if let digimons = digimonDict[self.levels[indexPath.section]] {
            cell.setDigimon(digimon: digimons[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return levels[section].rawValue
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return levels.count
    }
}

extension DigimonTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let digimons = digimonDict[self.levels[indexPath.section]],
           digimons.count > indexPath.row {
            let digimon = digimons[indexPath.row]
            let vc = DigimonDetailsViewController()
            vc.setDigimon(digimon: digimon)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
