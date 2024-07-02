//
//  HomeScreenRepositoryTests.swift
//  phantomgamesTests
//
//  Created by Aphiwe Shozi on 2024/07/01.
//

import XCTest
@testable import phantomgames

final class HomeScreenRepositoryTests: XCTestCase {
    
    var repository: HomeScreenRepository!
    
    override func setUp() {
        super.setUp()
        repository = HomeScreenRepository()
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    
    func testFetchAPIImageCollectionViewSuccess() {
        let expectation = expectation(description: "fetch APIImage CollectionView")
        repository.fetchAPIImageCollectionView { result in
            switch result {
            case .success(let games):
                XCTAssertFalse(games.isEmpty, "Expected non-empty game list")
            case .failure(let error):
                XCTFail("Expected success but got failure: \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchAPIImageTableViewSuccess() {
        let expectation = expectation(description: "fetch APIImage TableView")
        repository.fetchAPIImageTableView { result in
            switch result {
            case .success(let games):
                XCTAssertFalse(games.isEmpty, "Expected non-empty game list")
            case .failure(let error):
                XCTFail("Expected success but got failure: \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchHomeResultsForCollectionViewSuccess() {
        let expectation = self.expectation(description: "fetchHomeResultsForCollectionView")
        repository.fetchHomeResultsForCollectionView { result in
            switch result {
            case .success(let games):
                XCTAssertFalse(games.isEmpty, "Expected non-empty game list")
            case .failure(let error):
                XCTFail("Expected success but got failure: \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchHomeResultsForTableViewSuccess() {
        let expectation = expectation(description: "fetch HomeResults For TableView")
        repository.fetchHomeResultsForTableView { result in
            switch result {
            case .success(let games):
                XCTAssertFalse(games.isEmpty, "Expected non-empty game list")
            case .failure(let error):
                XCTFail("Expected success but got failure: \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchGameDetailResultsSuccess() {
        let gameId = 1
        let expectation = self.expectation(description: "fetchGameDetailResults")
        repository.fetchGameDetailResults(id: gameId) { result in
            switch result {
            case .success(let gameDetail):
                XCTAssertEqual(gameDetail.gameID, gameId, "Expected game ID to match")
            case .failure(let error):
                XCTFail("Expected success but got failure: \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchGameDetailResultsFailure() {
        let gameId = -1 // Assuming an invalid game ID for testing failure scenario
        let expectation = self.expectation(description: "fetch GameDetail Results Failure")
        let mockRepository = HomeScreenRepository()
        mockRepository.fetchGameDetailResults(id: gameId) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error, "Expected non-nil error")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
