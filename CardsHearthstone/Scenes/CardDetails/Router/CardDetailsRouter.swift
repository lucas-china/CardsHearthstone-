//
//  CardDetailsRouter.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import UIKit

protocol CardDetailsRoutingLogic: AnyObject {
    func routeToAlertError(errorMessage: String, action: ((UIAlertAction) -> Void)?)
}

final class CardDetailsRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
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

// MARK: - CardDetailsRoutingLogic
extension CardDetailsRouter: CardDetailsRoutingLogic {
    func routeToAlertError(errorMessage: String, action: ((UIAlertAction) -> Void)?) {
        showAlert(
            titleAlert: "Ops!",
            titleButton: "Tentar novamente",
            message: errorMessage,
            handlerAction: action
        )
    }
}
