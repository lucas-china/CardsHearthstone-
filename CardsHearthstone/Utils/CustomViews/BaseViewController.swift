//
//  BaseViewController.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import UIKit

class BaseViewController: UIViewController {
    lazy var spinnerView = SpinnerViewController()
    
    func shouldShowLoading(_ show: Bool) {
        if show {
            showLoading()
        } else {
            hideLoading()
        }
    }
    
    private func showLoading() {
        addChild(spinnerView)
        spinnerView.view.frame = view.frame
        view.addSubview(spinnerView.view)
        spinnerView.didMove(toParent: self)
    }
    
    private func hideLoading() {
        spinnerView.willMove(toParent: nil)
        spinnerView.view.removeFromSuperview()
        spinnerView.removeFromParent()
    }
}
