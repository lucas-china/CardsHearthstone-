//
//  CardListRouter.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import UIKit

protocol CardListRoutingLogic: AnyObject {
    func routeToCardDetails(_ cardId: String)
}

final class CardListRouter {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension CardListRouter: CardListRoutingLogic {
    func routeToCardDetails(_ cardId: String) {
        print("Route to new Scene! \(cardId)")
    }
}
