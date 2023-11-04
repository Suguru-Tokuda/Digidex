//
//  DigimonCollectionViewCell.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/3/23.
//

import UIKit

class DigimonCollectionViewCell: UICollectionViewCell {
    static let identifier = "DigimonCollectionViewCell"

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}

extension DigimonCollectionViewCell {
    func setDigimon(digimon: Digimon) {
        if let url = URL(string: digimon.img) {
            self.imageView.load(url: url)
        }
    }
}
