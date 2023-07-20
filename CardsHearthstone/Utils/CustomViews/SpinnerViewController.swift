//
//  SpinnerViewController.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            spinner.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            )
        ])
    }
}
