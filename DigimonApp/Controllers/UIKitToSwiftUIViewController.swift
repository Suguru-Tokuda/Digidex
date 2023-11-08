//
//  UIKitToSwiftUIViewController.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/7/23.
//

import UIKit
import SwiftUI

class UIKitToSwiftUIViewController: UIViewController {
    var toSwiftUIBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("To UIKit", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension UIKitToSwiftUIViewController {
    @objc private func handleBtnTap() {
        let vc = UIHostingController(rootView: SwiftUIView(data: "Hello", navigationController: self.navigationController))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIKitToSwiftUIViewController {
    private func setupUI() {
        view.addSubview(toSwiftUIBtn)
        toSwiftUIBtn.addTarget(self, action: #selector(handleBtnTap), for: .touchUpInside)
        applyConstraints()
    }
}

extension UIKitToSwiftUIViewController {
    private func applyConstraints() {
        let btnConstraints = [
            toSwiftUIBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toSwiftUIBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            toSwiftUIBtn.widthAnchor.constraint(equalToConstant: view.frame.width / 2)
        ]
        
        NSLayoutConstraint.activate(btnConstraints)
    }
}
