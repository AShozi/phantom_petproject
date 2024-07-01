//
//  HomescreenTest.swift
//  phantomgamesTests
//
//  Created by Aphiwe Shozi on 2024/07/01.
//

import XCTest
@testable import phantomgames

final class HomeScreenViewModelTests: XCTestCase {
    
    var viewModel: HomeScreenViewModel!
    var mockRepository: MockHomeScreenRepository!
    var mockDelegate: MockHomeScreenViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockHomeScreenRepository()
        mockDelegate = MockHomeScreenViewModelDelegate()
        viewModel = HomeScreenViewModel(repository: mockRepository, delegate: mockDelegate)
    }
    
    override func tearDown() {
        mockRepository = nil
        mockDelegate = nil
        viewModel = nil
        super.tearDown()
    }
    
    class MockHomeScreenRepository: HomeScreenRepositoryType {
        
        var shouldReturnError = false
        let mockGameList = [
            Game(
                gameID: 1,
                title: "game1",
                thumbnail: "Thumbnail1",
                shortDescription: "shortDes1",
                gameURL: "URL1",
                genre: "genre1",
                platform: "platform1",
                publisher: "publisher1",
                developer: "dev1",
                releaseDate: "Date1",
                freetogameProfileURL: "Profile1"
            ),
            Game(
                gameID: 2,
                title: "game2",
                thumbnail: "Thumbnail2",
                shortDescription: "shortDes2",
                gameURL: "URL2",
                genre: "genre2",
                platform: "platform2",
                publisher: "publisher2",
                developer: "dev2",
                releaseDate: "Date2",
                freetogameProfileURL: "Profile2"
            )
        ]
        
        func fetchAPIImageCollectionView(completion: @escaping (phantomgames.HomeScreenResult)) {
            if shouldReturnError {
                completion(.failure(.serverError))
            } else {
                completion(.success(mockGameList))
            }
        }
        
        func fetchAPIImageTableView(completion: @escaping (phantomgames.HomeScreenResult)) {
            if shouldReturnError {
                completion(.failure(.serverError))
            } else {
                completion(.success(mockGameList))
            }
        }

        func fetchHomeResultsForCollectionView(completion: @escaping (phantomgames.HomeScreenResult)) {
            if shouldReturnError {
                completion(.failure(.serverError))
            } else {
                completion(.success(mockGameList))
            }
        }
        
        func fetchHomeResultsForTableView(completion: @escaping (phantomgames.HomeScreenResult)) {
            if shouldReturnError {
                completion(.failure(.serverError))
            } else {
                completion(.success(mockGameList))
            }
        }
        
        func fetchGameDetailResults(id: Int, completion: @escaping (phantomgames.GameDetailResult)) {
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
            if shouldReturnError {
                completion(.failure(.serverError))
            } else {
                completion(.success(mockGameDetail))
            }
        }
    }

    class MockHomeScreenViewModelDelegate: HomeScreenViewModelDelegate {
        var setLoadingCalled = false
        var reloadCollectionViewCalled = false
        var reloadTableViewCalled = false
        var showErrorCalled = false
        var errorMessage: String?

        func setLoading(_ loading: Bool) {
            setLoadingCalled = loading
        }
        
        func reloadView() {}
        
        func reloadCollectionView() {
            reloadCollectionViewCalled = true
        }
        
        func reloadTableView() {
            reloadTableViewCalled = true
        }
        
        func show(error: String) {
            showErrorCalled = true
            errorMessage = error
        }
    }
  
    func testCollectionViewGamesCount() {
        viewModel.fetchCollectionViewGames()
        XCTAssertEqual(viewModel.collectionViewGamesCount, 2)
    }

    func testTableViewGamesCount() {
        viewModel.fetchTableViewGames()
        XCTAssertEqual(viewModel.tableViewGamesCount, 2)
    }

    func testAllGameList() {
        viewModel.fetchTableViewGames()
        XCTAssertEqual(viewModel.allGameList.count, 2)
    }
    
    func testCollectionViewGameAtIndex() {
        viewModel.fetchCollectionViewGames()
        let game = viewModel.collectionViewGame(atIndex: 0)
        XCTAssertNotNil(game)
        XCTAssertEqual(game?.title, "game1")
    }

    func testTableViewGameAtIndex() {
        viewModel.fetchTableViewGames()
        let game = viewModel.tableViewGame(atIndex: 0)
        XCTAssertNotNil(game)
        XCTAssertEqual(game?.title, "game1")
    }
    
    func testFetchGameDetail() {
        let expectation = self.expectation(description: "fetchGameDetail")
        viewModel.fetchGameDetail(id: 1) { result in
            switch result {
            case .success(let gameDetail):
                XCTAssertEqual(gameDetail.title, "game1")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchCollectionViewGamesSuccess() {
        viewModel.fetchCollectionViewGames()
        XCTAssertTrue(mockDelegate.setLoadingCalled)
        XCTAssertTrue(mockDelegate.reloadCollectionViewCalled)
        XCTAssertFalse(mockDelegate.showErrorCalled)
        XCTAssertEqual(viewModel.collectionViewGamesCount, 2)
    }
    
    func testFetchCollectionViewGamesFailure() {
        mockRepository.shouldReturnError = true
        viewModel.fetchCollectionViewGames()
        XCTAssertTrue(mockDelegate.setLoadingCalled)
        XCTAssertFalse(mockDelegate.reloadCollectionViewCalled)
        XCTAssertTrue(mockDelegate.showErrorCalled)
        XCTAssertNotNil(mockDelegate.errorMessage)
    }
    
    func testFetchTableViewGamesSuccess() {
        viewModel.fetchTableViewGames()
        XCTAssertTrue(mockDelegate.setLoadingCalled)
        XCTAssertTrue(mockDelegate.reloadTableViewCalled)
        XCTAssertFalse(mockDelegate.showErrorCalled)
        XCTAssertEqual(viewModel.tableViewGamesCount, 2)
    }
    
    func testFetchTableViewGamesFailure() {
        mockRepository.shouldReturnError = true
        viewModel.fetchTableViewGames()
        XCTAssertTrue(mockDelegate.setLoadingCalled)
        XCTAssertFalse(mockDelegate.reloadTableViewCalled)
        XCTAssertTrue(mockDelegate.showErrorCalled)
        XCTAssertNotNil(mockDelegate.errorMessage)
    }
}
