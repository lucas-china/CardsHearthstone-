//
//  ConfigurationView.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import Foundation

protocol ConfigurationView {
    func setupView()
    func setupSubViews()
    func setupConstraints()
    func configureViews()
}

extension ConfigurationView {
    func configureViews() {}
    
    func setupView() {
        setupSubViews()
        setupConstraints()
        configureViews()
    }
}
