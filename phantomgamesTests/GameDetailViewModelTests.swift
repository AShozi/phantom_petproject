//
//  DetailScreenTest.swift
//  phantomgamesTests
//
//  Created by Aphiwe Shozi on 2024/07/01.
//

import XCTest
@testable import phantomgames

final class GameDetailViewModelTests: XCTestCase {
    
    var viewModel: GameDetailViewModel!
    var mockRepository: MockGameDetailRepository!
    var mockDelegate: MockGameDetailViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockGameDetailRepository()
        mockDelegate = MockGameDetailViewModelDelegate()
        viewModel = GameDetailViewModel(repository: mockRepository, delegate: mockDelegate)
        
    }
    
    override func tearDown() {
        mockRepository = nil
        mockDelegate = nil
        viewModel = nil
        super.tearDown()
    }
    
    // Mock GameDetailRepository for testing purposes
    class MockGameDetailRepository: GameDetailRepositoryType {
        
        var shouldReturnError = false
        var addToFavoritesCalled = false
        
        func fetchGameDetail(id: Int, completion: @escaping (Result<GameDetail, APIError>) -> Void) {
            if shouldReturnError {
                completion(.failure(APIError.serverError))
            } else {
                let mockGameDetail = GameDetail(
                    gameID: id,
                    title: "game\(id)",
                    description: "Description of game\(id)",
                    genre: "genre\(id)",
                    platform: "platform\(id)",
                    publisher: "publisher\(id)",
                    developer: "developer\(id)",
                    releaseDate: "Date\(id)",
                    thumbnail: "Thumbnail\(id)",
                    gameURL: "URL\(id)"
                )
                completion(.success(mockGameDetail))
            }
        }
        
        func addToFavorites(gameDetail: GameDetail) {
            addToFavoritesCalled = true
            // Implement this if needed
        }
    }
    
    // Mock GameDetailViewModelDelegate for capturing delegate method calls
    class MockGameDetailViewModelDelegate: GameDetailViewModelDelegate {
        var setLoadingCalled = false
        var gameDetailFetchSuccessCalled = false
        var reloadViewCalled = false
        var showErrorCalled = false
        var errorMessage: String?
        
        func setLoading(_ loading: Bool) {
            setLoadingCalled = loading
        }
        
        func gameDetailFetchSuccess(success: Bool) {
            gameDetailFetchSuccessCalled = success
        }
        
        func reloadView() {
            reloadViewCalled = true
        }
        
        func show(error: String) {
            showErrorCalled = true
            errorMessage = error
        }
    }
//    
//    func testFetchGameDetailSuccess() {
//        // Given
//        let expectedGameID = 1
//        
//        // When
//        viewModel.updateGameID(gameID: expectedGameID)
//        
//        XCTAssertTrue(mockDelegate.setLoadingCalled)
//        XCTAssertTrue(mockDelegate.gameDetailFetchSuccessCalled)
//        XCTAssertFalse(mockDelegate.showErrorCalled)
//        XCTAssertEqual(viewModel.title, "game\(expectedGameID)")
//    }
//    
//    func testFetchGameDetailFailure() {
//        let expectedGameID = 1
//        mockRepository.shouldReturnError = true
//        
//        // When
//        viewModel.updateGameID(gameID: expectedGameID)
//        XCTAssertTrue(mockDelegate.setLoadingCalled)
//        XCTAssertFalse(mockDelegate.gameDetailFetchSuccessCalled)
//        XCTAssertTrue(mockDelegate.showErrorCalled)
//        XCTAssertNotNil(mockDelegate.errorMessage)
//    }
//    func testIsFavorite() {
//        // Given
//        let expectedGameID = 1
//        
//        // When
//        viewModel.updateGameID(gameID: expectedGameID)
//        
//        XCTAssertTrue(viewModel.isFavorite)
//    }
    func testAddToFavorites() {
        
        let expectedGameID = 1
        viewModel.updateGameID(gameID: expectedGameID)
        viewModel.addToFavorites()
        XCTAssertTrue(mockRepository.addToFavoritesCalled)
    }
}
