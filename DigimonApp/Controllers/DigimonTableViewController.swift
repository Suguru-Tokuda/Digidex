//
//  DigimonTableViewController.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/2/23.
//

import UIKit

class DigimonTableViewController: UIViewController {
    var levels: [DigimonLevel] = []
    var digimonDict: [DigimonLevel : [Digimon]] = [:]
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DigimonTableViewCell.self, forCellReuseIdentifier: DigimonTableViewCell.identifier)
        return tableView
    }()
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
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
        DispatchQueue.main.async {
            self.refreshControl.beginRefreshing()
        }
        
        DispatchQueue.global(qos: .utility).async {
            DigimonService.shared.getDigimons { [weak self] res in
                DispatchQueue.main.async {
                    switch res {
                    case .success(let digimons):
                        self?.processDigimons(digimons: digimons)
                        self?.tableView.reloadData()
                        self?.refreshControl.endRefreshing()
                    case .failure(let error):
                        let alert = UIAlertController(title: "Error fetching digimon data.", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                        self?.present(alert, animated: true)
                        self?.refreshControl.endRefreshing()
                    }
                }
            }
        }
    }

    private func processDigimons(digimons: [Digimon]) {
        let (digimonDict, levels) = DigimonService.shared.processDigimons(digimons: digimons)

        self.digimonDict = digimonDict
        self.levels = levels
    }
}

extension DigimonTableViewController {
    private func setUpUI() {
        view.addSubview(tableView)
        
        refreshControl.addTarget(self, action: #selector(self.refreshDigimons), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let digimon = digimons[indexPath.row]
                let vc = DigimonDetailsViewController()
                vc.setDigimon(digimon: digimon)

                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

// MARK: event handlers
extension DigimonTableViewController {
    @objc private func refreshDigimons() {
        self.getDigimons()
    }
}
