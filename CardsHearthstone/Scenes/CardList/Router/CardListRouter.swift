//
//  CardListRouter.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import UIKit

protocol CardListRoutingLogic: AnyObject {
    func routeToCardDetails(_ cardId: String)
    func routeToAlertError(errorMessage: String, action: ((UIAlertAction) -> Void)?)
}

final class CardListRouter {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    private func showAlert(
        titleAlert: String,
        titleButton: String,
        message: String,
        handlerAction: ((UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: titleAlert,
            message: message,
            preferredStyle: .alert
        )
        
        let tryAgainAction = UIAlertAction(
            title: titleButton,
            style: .default,
            handler: handlerAction
        )
        
        alert.addAction(tryAgainAction)
        
        viewController?.present(alert, animated: true)
    }
}

extension CardListRouter: CardListRoutingLogic {
    func routeToCardDetails(_ cardId: String) {
        let cardDetailsViewController = CardDetailsConfiguration.makeView(with: cardId)
        viewController?.navigationController?.pushViewController(cardDetailsViewController, animated: true)
    }
    
    func routeToAlertError(errorMessage: String, action: ((UIAlertAction) -> Void)?) {
        showAlert(
            titleAlert: "Ops!",
            titleButton: "Tentar novamente",
            message: errorMessage,
            handlerAction: action
        )
    }
}
