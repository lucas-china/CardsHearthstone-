//
//  CardDetailsWorker.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import Foundation

typealias CardDetailsResponse = [CardDetailsModels.Card.Response]

protocol CardDetailsWorkerLogic: AnyObject {
    func getCardDetails(cardId: String, completionHandler: @escaping (Result<CardDetailsResponse, NetworkError>) -> Void)
}

final class CardDetailsWorker {
    private let service: NetworkManagerProtocol
    
    init(service: NetworkManagerProtocol = NetworkManager()) {
        self.service = service
    }
}

// MARK: - CardDetailsWorkerLogic
extension CardDetailsWorker: CardDetailsWorkerLogic {
    func getCardDetails(cardId: String, completionHandler: @escaping (Result<CardDetailsResponse, NetworkError>) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "3f3a12a354msh392f5e7b4521bc9p11ce8bjsn12b073a234ad",
            "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"
          ]
        service.performDataTask(route: .cardDetails(cardId: cardId), httpMethod: .get, headers: headers) { (result: Result<CardDetailsResponse, NetworkError>) in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}
