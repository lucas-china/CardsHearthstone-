//
//  CardDetailsViewControllerTests.swift
//  CardsHearthstoneTests
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import XCTest
@testable import CardsHearthstone

final class CardDetailsViewControllerTests: XCTestCase {
    
    private func makeSUT(interactorSpy: CardDetailsBusinessLogic) -> CardDetailsViewController {
        let viewController = CardDetailsViewController(interactor: interactorSpy)
        return viewController
    }
    
    func test_getCardDetails_whenViewWillAppear() {
        // GIVEN
        let interactorSpy = CardDetailsInteractorSpy()
        let sut = makeSUT(interactorSpy: interactorSpy)
        
        // WHEN
        sut.viewWillAppear(true)
        
        // THEN
        XCTAssertTrue(interactorSpy.getCardDetailsCalled)
    }
    
}

extension CardDetailsViewControllerTests {
    class CardDetailsInteractorSpy: CardDetailsBusinessLogic {
        var getCardDetailsCalled = false
        
        func getCardDetails() {
            getCardDetailsCalled = true
        }
    }
}
