//
//  NetworkRoutes.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import Foundation

enum Routes {
    case cards
}

extension Routes {
    var endpoint: String {
        switch self {
        case .cards:
            return "cards.json"
        }
    }
}
