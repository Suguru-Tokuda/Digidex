//
//  UIImageView.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/2/23.
//

import UIKit

extension UIImageView {
    func load(url: URL, size: CGSize? = nil) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if var image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let size {
                            image = image.scalePreservingAspectRatio(targetSize: size)
                        }
                        self?.image = image
                    }
                }
            }
        }
    }
}
