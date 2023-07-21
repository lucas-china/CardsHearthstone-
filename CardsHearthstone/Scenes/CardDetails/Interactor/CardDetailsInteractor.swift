//
//  CardDetailsInteractor.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import Foundation

protocol CardDetailsBusinessLogic: AnyObject {
    func getCardDetails()
}

final class CardDetailsInteractor {
    private let cardId: String
    private let worker: CardDetailsWorkerLogic?
    private let presenter: CardDetailsPresentationLogic?
    
    init(cardId: String, worker: CardDetailsWorkerLogic, presenter: CardDetailsPresentationLogic) {
        self.worker = worker
        self.cardId = cardId
        self.presenter = presenter
    }
}

extension CardDetailsInteractor: CardDetailsBusinessLogic {
    func getCardDetails() {
        worker?.getCardDetails(cardId: cardId) { [weak presenter] result in
            guard let presenter else { return }
            switch result {
            case .success(let response):
                guard let card = response.first else { return }
                presenter.presentCardDetails(response: card)
            case .failure(let error):
                presenter.presentError(with: error.errorMessage)
            }
        }
    }
}
