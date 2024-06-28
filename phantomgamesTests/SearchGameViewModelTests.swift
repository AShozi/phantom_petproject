//
//  SearchViewModelTests.swift
//  phantomgamesTests
//
//  Created by Aphiwe Shozi on 2024/05/06.
//

import XCTest
@testable import phantomgames

final class SearchGameViewModelTests: XCTestCase {
    
    var viewModel: SearchGameViewModel!
    var mockRepository: MockSearchGameRepository!
    var mockDelegate: MockViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockSearchGameRepository()
        mockDelegate = MockViewModelDelegate()
        viewModel = SearchGameViewModel(repository: mockRepository, delegate: mockDelegate)
    }
    
    override func tearDown() {
        mockRepository = nil
        mockDelegate = nil
        viewModel = nil
        super.tearDown()
    }
    class MockSearchGameRepository: SearchGameRepositoryType {
        func fetchTableDetailResults(id: Int, completion: @escaping (phantomgames.TableDetailResult)) {
            <#code#>
        }
        
        func fetchAPIImage(completion: @escaping (SearchGameResult)) {
            let mockGames: [Game] = [
                Game(gameID: 1,
                     title: "game1",
                     thumbnail: "Thumbnail1",
                     shortDescription: "shortDes1",
                     gameURL: "URL1", 
                     genre: "genre1",
                     platform: "platform1",
                     publisher: "publisher1", 
                     developer: "dev1",
                     releaseDate: "Date1",
                     freetogameProfileURL: "Profile1"),
                Game(gameID: 2, 
                     title: "game2",
                     thumbnail: "Thumbnail2",
                     shortDescription: "shortDes2",
                     gameURL: "URL2", 
                     genre: "genre2",
                     platform: "platform2",
                     publisher: "publisher2",
                     developer: "dev2",
                     releaseDate: "Date2",
                     freetogameProfileURL: "Profile2")
            ]
            completion(.success(mockGames))
        }
        
        var shouldReturnError = false
        let mockGameList = [
            Game(gameID: 1, 
                 title: "game1",
                 thumbnail: "Thumbnail1",
                 shortDescription: "shortDes1",
                 gameURL: "URL1", 
                 genre: "genre1",
                 platform: "platform1", 
                 publisher: "publisher1",
                 developer: "dev1", 
                 releaseDate: "Date1",
                 freetogameProfileURL: "Profile1"),
            Game(gameID: 2, 
                 title: "game2",
                 thumbnail: "Thumbnail2",
                 shortDescription: "shortDes2",
                 gameURL: "URL2",
                 genre: "genre2",
                 platform: "platform2",
                 publisher: "publisher2",
                 developer: "dev2",
                 releaseDate: "Date2",
                 freetogameProfileURL: "Profile2")
        ]
        
        func fetchSearchResults(completion: @escaping (SearchGameResult)) {
            if shouldReturnError {
                completion(.failure(APIError.serverError))
            } else {
                completion(.success(mockGameList))
            }
        }
        
        func fetchGames(fromURL url: String, completion: @escaping (SearchGameResult)) {
            if shouldReturnError {
                completion(.failure(APIError.serverError))
            } else {
                completion(.success(mockGameList))
            }
        }
    }

    class MockViewModelDelegate: ViewModelDelegate {
        var showErrorCalled = false
        var errorMessage: String?
        
        func reloadView() {}
        
        func show(error: String) {
            showErrorCalled = true
            errorMessage = error
        }
    }
    
    func testGamelistCount () {
        viewModel.fetchSearchResults()
        let result = viewModel.gameListCount
        XCTAssertEqual(result, 2)
    }
    
    func testGameAtIndex () {
        viewModel.fetchSearchResults()
        let result = viewModel.game(atIndex: 0)?.title
        XCTAssertNotNil(result)
        XCTAssertEqual(result, "game1")
    }
    
    func testFetchSearchResultSuccess() {
        
        class SuccessDelegate: MockViewModelDelegate {
            
            var testException: XCTestExpectation?
            
            override func reloadView() {
                testException?.fulfill()
            }
        }
        let successDelegate = SuccessDelegate()
        viewModel = SearchGameViewModel(
            repository: MockSearchGameRepository(),
            delegate: successDelegate)
        
        successDelegate.testException = XCTestExpectation(description:"We expect this function to succeed")
        
        viewModel.fetchSearchResults()
    }
    
    func testFetchSearchResultFail(){
        
        let mockRepository = MockSearchGameRepository()
        let mockDelegate = MockViewModelDelegate()
        
        mockRepository.shouldReturnError = true
        viewModel = SearchGameViewModel(repository: mockRepository, delegate: mockDelegate)
        
        viewModel.fetchSearchResults()
        
        XCTAssertTrue(mockDelegate.showErrorCalled)
        XCTAssertNotNil(mockDelegate.errorMessage)
        
    }
}
