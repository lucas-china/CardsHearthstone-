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
    
    weak var viewDelegate: CardDetailsViewDelegate?
    let interactor: CardDetailsBusinessLogic
    var router: CardDetailsRoutingLogic?
    
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
        getCardDetails()
    }
    
    private func getCardDetails() {
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
        shouldShowLoading(false)
        router?.routeToAlertError(errorMessage: errorMessage) { [weak self] _ in
            guard let self else { return }
            self.getCardDetails()
        }
    }
}
