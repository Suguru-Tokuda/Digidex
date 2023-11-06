//
//  DigimonCollectionViewController.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/3/23.
//

import UIKit

class DigimonCollectionViewController: CustomNavigationController {
    var levels: [DigimonLevel] = []
    var digimonDict: [DigimonLevel : [Digimon]] = [:]
    
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DigimonCollectionViewCell.self, forCellWithReuseIdentifier: DigimonCollectionViewCell.identifier)
        collectionView.register(DigimonCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DigimonCollectionHeaderView.identifier)
        return collectionView
    }()
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        getDigimonsWithDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = contentView.bounds        
    }
}

extension DigimonCollectionViewController {
    private func setUpUI() {
        contentView.addSubview(collectionView)
        view.addSubview(contentView)
        
        refreshControl.addTarget(self, action: #selector(self.refreshDigimonCollection), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        applyConstraints()
    }
}

extension DigimonCollectionViewController {
    private func applyConstraints() {
        let contentViewConstraints = [
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(contentViewConstraints)
    }
}

extension DigimonCollectionViewController {
    private func getDigimonsWithDelegate() {
        DispatchQueue.main.async {
            self.digimonDict = [:]
            self.levels = []
        }
        var digimonService: DigimonService? = DigimonService()
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

extension DigimonCollectionViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DigimonCollectionViewCell.identifier, for: indexPath) as? DigimonCollectionViewCell {
            if !levels.isEmpty {
                let level = levels[indexPath.section]
                if let digimons = digimonDict[level] {
                    let digimon = digimons[indexPath.item]
                    cell.setDigimon(digimon: digimon)
                }
            }

            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if levels.count > section {
            if let digimons = digimonDict[self.levels[section]] {
                return digimons.count
            }
        }
        
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.levels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DigimonCollectionHeaderView.identifier, for: indexPath) as! DigimonCollectionHeaderView
        
        let level = levels[indexPath.section]
        header.setValue(level: level.rawValue)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}

extension DigimonCollectionViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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

extension DigimonCollectionViewController : DigimonsResponseProtocol {
    func didFinishWithResponse(digimons: [Digimon]) {
        DispatchQueue.main.async {
            self.processDigimons(digimons: digimons)
            self.collectionView.reloadData()

            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func didFishWithError(error: Error) {
        let alert = UIAlertController(title: "Error fetching digimon data.", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }
}

extension DigimonCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns = 3
        let width = (Int(collectionView.bounds.width) - 40) / columns
        let height = Int(Double(width) * 1.2)
        return CGSize(width: width, height: height)
    }
}

// MARK: event handlers
extension DigimonCollectionViewController {
    @objc private func refreshDigimonCollection() {
        self.getDigimonsWithDelegate()
    }
}
