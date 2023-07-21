//
//  CardDetailsConfiguration.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import UIKit

class CardDetailsConfiguration {
    static func makeView(with cardId: String) -> UIViewController {
        let viewController = CardDetailsViewController()
        return viewController
    }
}
