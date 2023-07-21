//
//  CardListPresenterTests.swift
//  CardsHearthstoneTests
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import Foundation

import XCTest
@testable import CardsHearthstone


final class CardListPresenterTests: XCTestCase {
    
    private func makeSUT(viewControllerSpy: CardListDisplayLogic) -> CardListPresenter {
        let presenter = CardListPresenter()
        presenter.viewController = viewControllerSpy
        return presenter
    }
    
    
    func test_displayCardList_whenPresentCardList() {
        // GIVEN
        let viewControllerSpy = CardListViewControllerSpy()
        let sut = makeSUT(viewControllerSpy: viewControllerSpy)
        
        // WHEN
        sut.presentCardList(response: [CardListSeeds.response])
        
        // THEN
        XCTAssertTrue(viewControllerSpy.displayCardListCalled)
    }
    
    func test_displayError_whenPresentError() {
        // GIVEN
        let viewControllerSpy = CardListViewControllerSpy()
        let sut = makeSUT(viewControllerSpy: viewControllerSpy)
        
        // WHEN
        sut.presentError(errorMessage: "Error Teste")
        
        // THEN
        XCTAssertTrue(viewControllerSpy.displayErrorCalled)
    }
    
}

extension CardListPresenterTests {
    class CardListViewControllerSpy: CardListDisplayLogic {
        var displayCardListCalled = false
        var displayErrorCalled = false
        
        func displayCardList(_ viewModel: [CardsHearthstone.CardListModels.Cards.ViewModel]) {
            displayCardListCalled = true
        }
        
        func displayError(_ errorMessage: String) {
            displayErrorCalled = true
        }
    }
}
