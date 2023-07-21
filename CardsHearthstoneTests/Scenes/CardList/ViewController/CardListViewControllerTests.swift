//
//  CardListViewControllerTests.swift
//  CardsHearthstoneTests
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import XCTest
@testable import CardsHearthstone

final class CardListViewControllerTests: XCTestCase {
    
    private func makeSUT(interactorSpy: CardListBusinessLogic) -> CardListViewController {
        let viewController = CardListViewController(interactor: interactorSpy)
        return viewController
    }
    
    func test_getCardList_whenViewWillAppear() {
        // GIVEN
        let interactorSpy = CardListInteractorSpy()
        let sut = makeSUT(interactorSpy: interactorSpy)
        
        // WHEN
        sut.viewWillAppear(true)
        
        // THEN
        XCTAssertTrue(interactorSpy.getCardListCalled)
    }
}

extension CardListViewControllerTests {
    class CardListInteractorSpy: CardListBusinessLogic {
        var getCardListCalled = false
        
        func getCardList() {
            getCardListCalled = true
        }
    }
}
