//
//  NetworkRoutes.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import Foundation

enum Routes {
    case cards
    case cardDetails(cardId: String)
}

extension Routes {
    var endpoint: String {
        switch self {
        case .cards:
            let baseURL = "https://api.hearthstonejson.com/v1/latest/enUS/"
            return baseURL + "cards.json"
        case .cardDetails(let cardId):
            let baseURL = "https://omgvamp-hearthstone-v1.p.rapidapi.com/"
            return baseURL + "cards/\(cardId)"
        }
    }
}
