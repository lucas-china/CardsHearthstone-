//
//  CardDetailsInteractorTests.swift
//  CardsHearthstoneTests
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import XCTest
@testable import CardsHearthstone

final class CardDetailsInteractorTests: XCTestCase {
    
    private func makeSUT(workerSpy: CardDetailsWorkerLogic, presenterSpy: CardDetailsPresentationLogic) -> CardDetailsInteractor {
        let interactor = CardDetailsInteractor(cardId: "", worker: workerSpy, presenter: presenterSpy)
        return interactor
    }
    
    func test_getCardDetails_whenAPIReturnsSuccess() {
        // GIVEN
        let workerSpy = CardDetailsWorkerSpy()
        let presenterSpy = CardDetailsPresenterSpy()
        let sut = makeSUT(workerSpy: workerSpy, presenterSpy: presenterSpy)
        
        // WHEN
        sut.getCardDetails()
        
        // THEN
        XCTAssertTrue(presenterSpy.presentCardDetailsCalled)
    }
    
    func test_getCardDetails_whenAPIReturnsFailure() {
        // GIVEN
        let workerSpy = CardDetailsWorkerSpy()
        workerSpy.completionHandlerMock = .failure(NetworkError.networkError)
        let presenterSpy = CardDetailsPresenterSpy()
        let sut = makeSUT(workerSpy: workerSpy, presenterSpy: presenterSpy)
        
        // WHEN
        sut.getCardDetails()
        
        // THEN
        XCTAssertTrue(presenterSpy.presentErrorCalled)
    }
    
}

extension CardDetailsInteractorTests {
    class CardDetailsWorkerSpy: CardDetailsWorkerLogic {
        var completionHandlerMock: Result<CardDetailsResponse, NetworkError> = .success([CardDetailsSeeds.response])
        
        func getCardDetails(cardId: String, completionHandler: @escaping (Result<CardDetailsResponse, NetworkError>) -> Void) {
            completionHandler(completionHandlerMock)
        }
    }
    
    class CardDetailsPresenterSpy: CardDetailsPresentationLogic {
        var presentCardDetailsCalled = false
        var presentErrorCalled = false
        
        func presentCardDetails(response: CardDetailsModels.Card.Response) {
            presentCardDetailsCalled = true
        }
        
        func presentError(with errorMessage: String) {
            presentErrorCalled = true
        }
    }
}
