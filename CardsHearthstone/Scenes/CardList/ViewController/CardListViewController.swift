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
    
    let interactor: CardListBusinessLogic?
    lazy var cardView = CardListView()
    
    init(interactor: CardListBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = cardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.getCardList()
    }
    
}

extension CardListViewController: CardListDisplayLogic {
    func displayCardList(_ viewModel: [CardListModels.Cards.ViewModel]) {
        print(viewModel.count)
        cardView.list = viewModel
    }
    
    func displayError(_ errorMessage: String) {
        print(errorMessage)
    }
}
