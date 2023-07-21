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

class CardDetailsViewController: BaseViewController {
    
    lazy var cardDetailsView = CardDetailsView()
    
    let interactor: CardDetailsBusinessLogic
    weak var viewDelegate: CardDetailsViewDelegate?
    
    // MARK: - init
    init(interactor: CardDetailsBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        viewDelegate = cardDetailsView
        view = cardDetailsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shouldShowLoading(true)
        interactor.getCardDetails()
    }
}

// MARK: - CardDetailsDisplayLogic
extension CardDetailsViewController: CardDetailsDisplayLogic {
    func displayCard(viewModel: CardDetailsModels.Card.ViewModel) {
        shouldShowLoading(false)
        viewDelegate?.updateView(card: viewModel)
    }
    
    func displayError(errorMessage: String) {
        print(errorMessage)
    }
}
