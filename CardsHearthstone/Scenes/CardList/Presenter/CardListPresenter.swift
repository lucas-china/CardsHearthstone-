//
//  CardListPresenter.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import Foundation

protocol CardListPresentationLogic: AnyObject {
    func presentCardList(response: [CardListModels.Cards.Response])
    func presentError(errorMessage: String)
}

final class CardListPresenter {
    weak var viewController: CardListDisplayLogic?
}

extension CardListPresenter: CardListPresentationLogic {
    func presentCardList(response: [CardListModels.Cards.Response]) {
        let viewModel = response.map { response in
            return CardListModels.Cards.ViewModel(id: response.id, name: response.name)
            
        }
        viewController?.displayCardList(viewModel)
    }
    
    func presentError(errorMessage: String) {
        viewController?.displayError(errorMessage)
    }
}
