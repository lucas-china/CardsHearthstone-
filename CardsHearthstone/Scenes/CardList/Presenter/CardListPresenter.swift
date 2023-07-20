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
//    weak var viewController: DisplayLogic?
}

extension CardListPresenter: CardListPresentationLogic {
    func presentCardList(response: [CardListModels.Cards.Response]) {
        print(response.count)
    }
    
    func presentError(errorMessage: String) {
        print(errorMessage)
    }
}
