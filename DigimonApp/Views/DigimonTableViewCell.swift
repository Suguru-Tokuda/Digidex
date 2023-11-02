//
//  DigimonTableViewCell.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/2/23.
//

import UIKit

class DigimonTableViewCell: UITableViewCell {
    static let identifier = "DigimonTableViewCell"
    private var digimon: Digimon?
    
    var digimonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var levelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension DigimonTableViewCell {
    private func setUpUI() {
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(levelLabel)
        
        contentView.addSubview(digimonImageView)
        contentView.addSubview(nameStackView)
        
        applyConstraints()
    }
}

extension DigimonTableViewCell {
    private func applyConstraints() {
        let digimonImageViewConstraints = [
            digimonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            digimonImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let nameStackViewConstraints = [
            nameStackView.leadingAnchor.constraint(equalTo: digimonImageView.trailingAnchor, constant: 20),
            nameStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(digimonImageViewConstraints)
        NSLayoutConstraint.activate(nameStackViewConstraints)
    }
}

extension DigimonTableViewCell {
    func setDigimon(digimon: Digimon) {
        self.digimon = digimon
        if let url = URL(string: digimon.img) {
            self.digimonImageView.load(url: url, size: CGSize(width: 60, height: 60))
        }
        self.nameLabel.text = digimon.name
        self.levelLabel.text = digimon.level
    }
}
