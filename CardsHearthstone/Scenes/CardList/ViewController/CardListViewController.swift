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

class CardListViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.getCardList()
    }
    
}

// MARK: - CardListDisplayLogic
extension CardListViewController: CardListDisplayLogic {
    func displayCardList(_ viewModel: [CardListModels.Cards.ViewModel]) {
        cardView.list = viewModel
    }
    
    func displayError(_ errorMessage: String) {
        print(errorMessage)
    }
}

// MARK: - CardListViewDelegate
extension CardListViewController: CardListViewDelegate {
    func cardItemDidSelect(_ card: CardListModels.Cards.ViewModel) {
        router?.routeToCardDetails(card.id)
    }
}
