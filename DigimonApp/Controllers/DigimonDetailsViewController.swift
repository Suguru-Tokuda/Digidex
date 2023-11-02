//
//  DigimonDetailsViewController.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/2/23.
//

import UIKit

class DigimonDetailsViewController: UIViewController {
    private var digimon: Digimon?

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()

        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    var mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var digimonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var digimonLavelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(mainImage)
        scrollViewContainer.addArrangedSubview(digimonNameLabel)
        scrollViewContainer.addArrangedSubview(digimonLavelLabel)
        applyConstraints()
    }
}

extension DigimonDetailsViewController {
    private func setUpUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(mainImage)
        scrollViewContainer.addArrangedSubview(digimonNameLabel)
        scrollViewContainer.addArrangedSubview(digimonLavelLabel)
        view.addSubview(scrollView)
        
        applyConstraints()
    }
    
    func setDigimon(digimon: Digimon) {
        self.digimon = digimon
        
        if let digimon = self.digimon {
            if let url = URL(string: digimon.img) {
                let width = view.bounds.width * 0.8
                self.mainImage.load(url: url, size: CGSize(width: width, height: width))
            }
            
            digimonNameLabel.text = digimon.name
            digimonLavelLabel.text = digimon.level
        }
    }
}

extension DigimonDetailsViewController {
    private func applyConstraints() {
       let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        let scrollViewContainerConstraints = [
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(scrollViewContainerConstraints)
    }
}
