//
//  CardDetailsPresenter.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import Foundation

protocol CardDetailsPresentationLogic: AnyObject {
    func presentCardDetails(response: CardDetailsModels.Card.Response)
    func presentError(with errorMessage: String)
}

final class CardDetailsPresenter {
    weak var viewController: CardDetailsDisplayLogic?
}

extension CardDetailsPresenter: CardDetailsPresentationLogic {
    func presentCardDetails(response: CardDetailsModels.Card.Response) {
        let viewModel = CardDetailsModels.Card.ViewModel(
            id: response.cardId,
            name: response.name,
            text: response.text,
            flavor: response.flavor,
            attack: response.attack,
            cost: response.cost,
            elite: response.elite,
            faction: response.faction,
            health: response.health,
            rarity: response.rarity,
            cardSet: response.set,
            type: response.type
        )
        
        viewController?.displayCard(viewModel: viewModel)
    }
    
    func presentError(with errorMessage: String) {
        viewController?.displayError(errorMessage: errorMessage)
    }
}
