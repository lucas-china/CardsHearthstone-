//
//  CardDetailsPresenterTests.swift
//  CardsHearthstoneTests
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import XCTest
@testable import CardsHearthstone

final class CardDetailsPresenterTests: XCTestCase {
    
    private func makeSUT(viewControllerSpy: CardDetailsDisplayLogic) -> CardDetailsPresenter {
        let presenter = CardDetailsPresenter()
        presenter.viewController = viewControllerSpy
        return presenter
    }
    
    
    func test_displayCard_whenPresentCard() {
        // GIVEN
        let viewControllerSpy = CardDetailsViewControllerSpy()
        let sut = makeSUT(viewControllerSpy: viewControllerSpy)
        
        // WHEN
        sut.presentCardDetails(response: CardDetailsSeeds.response)
        
        // THEN
        XCTAssertTrue(viewControllerSpy.displayCardCalled)
    }
    
    func test_displayError_whenPresentError() {
        // GIVEN
        let viewControllerSpy = CardDetailsViewControllerSpy()
        let sut = makeSUT(viewControllerSpy: viewControllerSpy)
        
        // WHEN
        sut.presentError(with: "Error Teste")
        
        // THEN
        XCTAssertTrue(viewControllerSpy.displayErrorCalled)
    }
}

extension CardDetailsPresenterTests {
    class CardDetailsViewControllerSpy: CardDetailsDisplayLogic {
        var displayCardCalled = false
        var displayErrorCalled = false
        
        func displayCard(viewModel: CardsHearthstone.CardDetailsModels.Card.ViewModel) {
            displayCardCalled = true
        }
        
        func displayError(errorMessage: String) {
            displayErrorCalled = true
        }
    }
}
