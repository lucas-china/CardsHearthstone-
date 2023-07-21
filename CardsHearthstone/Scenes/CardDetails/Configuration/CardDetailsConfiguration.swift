//
//  CardDetailsConfiguration.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import UIKit

class CardDetailsConfiguration {
    static func makeView(with cardId: String) -> UIViewController {
        let worker = CardDetailsWorker()
        let interactor = CardDetailsInteractor(cardId: cardId, worker: worker)
        let viewController = CardDetailsViewController(interactor: interactor)
        
        return viewController
    }
}
