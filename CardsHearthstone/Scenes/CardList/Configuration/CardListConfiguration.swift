//
//  CardListConfiguration.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import UIKit


class CardListConfiguration {
    static func makeView() -> UIViewController {
        let worker = CardListWorker()
        let presenter = CardListPresenter()
        let interactor = CardListInteractor(worker: worker, presenter: presenter)
        let viewController = CardListViewController(interactor: interactor)
        
        presenter.viewController = viewController
        return viewController
    }
}
