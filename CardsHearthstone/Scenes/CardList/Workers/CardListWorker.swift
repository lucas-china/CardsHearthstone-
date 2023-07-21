//
//  CardListWorker.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import Foundation

typealias CardListResponse = [CardListModels.Cards.Response]

protocol CardListWorkerLogic: AnyObject {
    func getCardList(completionHandler: @escaping (Result<CardListResponse, NetworkError>) -> Void)
}

final class CardListWorker {
    private let service: NetworkManagerProtocol
    
    init(service: NetworkManagerProtocol = NetworkManager()) {
        self.service = service
    }
}

// MARK: - CardListWorkerLogic
extension CardListWorker: CardListWorkerLogic {
    func getCardList(completionHandler: @escaping (Result<CardListResponse, NetworkError>) -> Void) {
        service.performDataTask(route: .cards, httpMethod: .get, headers: nil) { (result: Result<CardListResponse, NetworkError>) in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}
