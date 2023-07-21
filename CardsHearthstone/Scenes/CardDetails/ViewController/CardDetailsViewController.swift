//
//  CardDetailsViewController.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import UIKit

protocol CardDetailsDisplayLogic: AnyObject {
    func displayCard(viewModel: CardDetailsModels.Card.ViewModel)
    func displayError(errorMessage: String)
}

class CardDetailsViewController: UIViewController {
    
    let interactor: CardDetailsBusinessLogic
    
    init(interactor: CardDetailsBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .blue
        
        interactor.getCardDetails()
    }
}

extension CardDetailsViewController: CardDetailsDisplayLogic {
    func displayCard(viewModel: CardDetailsModels.Card.ViewModel) {
        print(viewModel.name)
    }
    
    func displayError(errorMessage: String) {
        print(errorMessage)
    }
}
