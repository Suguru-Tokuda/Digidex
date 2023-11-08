//
//  SwiftUIView.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/7/23.
//

import SwiftUI
import UIKit

struct SwiftUIView: View {
    var data: String
    var navigationController: UINavigationController?

    var body: some View {
        ZStack {
            Button(action: {
                handleGoToUIVCBtnTapped()
            }, label: {
                Text("Go to UI View Controller")
            })
        }
    }
}

extension SwiftUIView {
    func handleGoToUIVCBtnTapped() {
        let vc = UIViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

#Preview {
    SwiftUIView(data: "Hello world")
}
