//
//  CardListViewController.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import UIKit

protocol CardListDisplayLogic: AnyObject {
    func displayCardList(_ viewModel: [CardListModels.Cards.ViewModel])
    func displayError(_ errorMessage: String)
}

class CardListViewController: BaseViewController {
    
    lazy var cardView = CardListView()
    
    let interactor: CardListBusinessLogic?
    var router: CardListRoutingLogic?
    
    // MARK: - Init
    init(interactor: CardListBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    override func loadView() {
        cardView.delegate = self
        view = cardView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCardList()
    }
    
    private func getCardList() {
        shouldShowLoading(true)
        interactor?.getCardList()
    }
}

// MARK: - CardListDisplayLogic
extension CardListViewController: CardListDisplayLogic {
    func displayCardList(_ viewModel: [CardListModels.Cards.ViewModel]) {
        shouldShowLoading(false)
        cardView.list = viewModel
    }
    
    func displayError(_ errorMessage: String) {
        shouldShowLoading(false)
        router?.routeToAlertError(errorMessage: errorMessage) { [weak self] _ in
            guard let self else { return }
            self.getCardList()
        }
    }
}

// MARK: - CardListViewDelegate
extension CardListViewController: CardListViewDelegate {
    func cardItemDidSelect(_ card: CardListModels.Cards.ViewModel) {
        router?.routeToCardDetails(card.id)
    }
}
