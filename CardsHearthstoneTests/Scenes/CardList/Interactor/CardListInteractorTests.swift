//
//  CardListInteractorTests.swift
//  CardsHearthstoneTests
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import XCTest
@testable import CardsHearthstone

final class CardListInteractorTests: XCTestCase {

    private func makeSUT(workerSpy: CardListWorkerLogic, presenterSpy: CardListPresentationLogic) -> CardListInteractor {
        let interactor = CardListInteractor(worker: workerSpy, presenter: presenterSpy)
        return interactor
    }
    
    func test_presentCardList_whenAPIReturnsSuccess() {
        // GIVEN
        let workerSpy = CardListWorkerSpy()
        let presenterSpy = CardListPresenterSpy()
        let sut = makeSUT(workerSpy: workerSpy, presenterSpy: presenterSpy)
        
        // WHEN
        sut.getCardList()
        
        // THEN
        XCTAssertTrue(presenterSpy.presentCardListCalled)
    }
    
    func test_presentError_whenAPIReturnsFailure() {
        // GIVEN
        let workerSpy = CardListWorkerSpy()
        workerSpy.completionHandlerMock = .failure(NetworkError.networkError)
        let presenterSpy = CardListPresenterSpy()
        let sut = makeSUT(workerSpy: workerSpy, presenterSpy: presenterSpy)
        
        // WHEN
        sut.getCardList()
        
        // THEN
        XCTAssertTrue(presenterSpy.presentErrorCalled)
    }
    
}

extension CardListInteractorTests {
    class CardListWorkerSpy: CardListWorkerLogic {
        
        var completionHandlerMock: Result<CardListResponse, NetworkError> = .success([CardListSeeds.response])
        
        func getCardList(completionHandler: @escaping (Result<CardListResponse, NetworkError>) -> Void) {
            completionHandler(completionHandlerMock)
        }
    }
    
    class CardListPresenterSpy: CardListPresentationLogic {
        var presentCardListCalled = false
        var presentErrorCalled = false
        
        func presentCardList(response: [CardListModels.Cards.Response]) {
            presentCardListCalled = true
        }
        
        func presentError(errorMessage: String) {
            presentErrorCalled = true
        }
    }
}
