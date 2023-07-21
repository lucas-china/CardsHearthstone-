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
        let presenter = CardDetailsPresenter()
        let interactor = CardDetailsInteractor(cardId: cardId, worker: worker, presenter: presenter)
        let viewController = CardDetailsViewController(interactor: interactor)
        let router = CardDetailsRouter(viewController: viewController)
        
        presenter.viewController = viewController
        viewController.router = router
        return viewController
    }
}
