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
    
    init(cardId: String, worker: CardDetailsWorkerLogic) {
        self.worker = worker
        self.cardId = cardId
    }
}

extension CardDetailsInteractor: CardDetailsBusinessLogic {
    func getCardDetails() {
        worker?.getCardDetails(cardId: cardId) { result in
            switch result {
            case .success(let response):
                print(response.first?.name)
            case .failure(let error):
                print(error.errorMessage)
            }
        }
    }
}
