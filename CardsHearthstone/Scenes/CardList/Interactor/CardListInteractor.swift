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
    // var presenter: CardListPresentationLogic?
    
    init(worker: CardListWorkerLogic?) {
        self.worker = worker
    }
    
}

extension CardListInteractor: CardListBusinessLogic {
    func getCardList() {
        worker?.getCardList(completionHandler: { result in
            switch result {
            case .success(let response):
                print(response.count)
            case .failure(let error):
                print(error.errorMessage)
            }
        })
    }
}
