//
//  CardListInteractor.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import Foundation

protocol CardListBusinessLogic: AnyObject {
    func getCardList()
}

final class CardListInteractor {
    
    let worker: CardListWorkerLogic?
    let presenter: CardListPresentationLogic?
    
    init(worker: CardListWorkerLogic, presenter: CardListPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
}

extension CardListInteractor: CardListBusinessLogic {
    func getCardList() {
        worker?.getCardList(completionHandler: { [weak presenter] result in
            guard let presenter else { return }
            switch result {
            case .success(let response):
                presenter.presentCardList(response: response)
            case .failure(let error):
                presenter.presentError(errorMessage: error.errorMessage)
            }
        })
    }
}
