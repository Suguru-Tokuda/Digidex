//
//  DigimonCollectionHeaderView.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/3/23.
//

import UIKit

class DigimonCollectionHeaderView: UICollectionReusableView {
    static let identifier = "DigimonCollectionHeaderView"
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    func setValue(level: String) {
        levelLabel.text = level
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(levelLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        levelLabel.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//extension DigimonCollectionHeaderView {
//    private func applyConstraints() {
//        let lavelLabelConstraints = [
//            levelLabel.leadingAnchor.constraint(equalTo: )
//        ]
//    }
//}
