//
//  HomeScreenViewControllerTests.swift
//  phantomgamesTests
//
//  Created by Aphiwe Shozi on 2024/07/01.
//

import XCTest
//@testable import phantomgames
//
//final class HomeScreenViewControllerTests: XCTestCase {
//    
//    var viewController: HomeScreenViewController!
//    var mockViewModel: MockHomeScreenViewModel!
//    var mockDelegate: MockHomeScreenViewModelDelegate!
//    
//    override func setUp() {
//        super.setUp()
//        
//        // Instantiate the view controller
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        viewController = storyboard.instantiateViewController(withIdentifier: "HomeScreenViewController") as? HomeScreenViewController
//        mockViewModel = MockHomeScreenViewModel(repository: HomeScreenRepository(), delegate: mockDelegate)
//        viewController.viewModel = mockViewModel
//        
//        // Load the view hierarchy
//        viewController.loadViewIfNeeded()
//    }
//    
//    override func tearDown() {
//        viewController = nil
//        mockViewModel = nil
//        mockDelegate = nil
//        super.tearDown()
//    }
//    
//    func testViewDidLoadCallsSetUpController() {
//        // Arrange
//        let spy = XCTestExpectation(description: "Set up controller called")
//        
//        // Act
//        viewController.viewDidLoad()
//        
//        // Assert
//        XCTAssertTrue(mockViewModel.fetchCollectionViewGamesCalled)
//        XCTAssertTrue(mockViewModel.fetchTableViewGamesCalled)
//    }
//    
//    func testCollectionViewDataSource() {
//        // Arrange
//        mockViewModel.fetchCollectionViewGames()
//        viewController.viewModel = mockViewModel
//        
//        // Act
//        viewController.collectionView(viewController.homeCollectionView, numberOfItemsInSection: 0)
//        
//        // Assert
//        XCTAssertEqual(viewController.viewModel.collectionViewGamesCount, 2)
//    }
//    
//    func testTableViewDataSource() {
//        // Arrange
//        mockViewModel.fetchTableViewGames()
//        viewController.viewModel = mockViewModel
//        
//        // Act
//        viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
//        
//        // Assert
//        XCTAssertEqual(viewController.viewModel.tableViewGamesCount, 2)
//    }
//    
//    func testCollectionViewCellForItemAt() {
//        // Arrange
//        mockViewModel.fetchCollectionViewGames()
//        viewController.viewModel = mockViewModel
//        
//        let indexPath = IndexPath(item: 0, section: 0)
//        let cell = viewController.collectionView(viewController.homeCollectionView, cellForItemAt: indexPath) as! CustomCollectionViewCell
//        
//        // Act
//        let game = viewController.viewModel.collectionViewGame(atIndex: indexPath.item)
//        
//        // Assert
//        XCTAssertNotNil(game)
//        XCTAssertEqual(game?.title, "game1")
//        XCTAssertTrue(cell.configCellWith(game: game!) is CustomCollectionViewCell)
//    }
//    
//    func testDidSelectItemAt() {
//        // Arrange
//        mockViewModel.fetchCollectionViewGames()
//        viewController.viewModel = mockViewModel
//        
//        let indexPath = IndexPath(item: 0, section: 0)
//        
//        // Act
//        viewController.collectionView(viewController.homeCollectionView, didSelectItemAt: indexPath)
//        
//        // Assert
//        XCTAssertEqual(viewController.viewModel.collectionViewGame(atIndex: indexPath.item)?.gameID, 1)
//        XCTAssertTrue(viewController.performSegue(withIdentifier: Constants.SegueIdentifiers.GameDetailScreenSegue, sender: 1))
//    }
//    
//    func testPcImageTapped() {
//        // Arrange
//        let expectation = XCTestExpectation(description: "Navigate to PC Games URL")
//        
//        // Act
//        viewController.pcImageTapped()
//        
//        // Assert
//        XCTAssertTrue(viewController.navigationController?.topViewController is SearchGameViewController)
//        XCTAssertEqual((viewController.navigationController?.topViewController as! SearchGameViewController).gamesURL, Constants.Endpoints.pcGamesURL)
//    }
//    
//    func testBrowserImageTapped() {
//        // Arrange
//        let expectation = XCTestExpectation(description: "Navigate to Browser Games URL")
//        
//        // Act
//        viewController.browserImageTapped()
//        
//        // Assert
//        XCTAssertTrue(viewController.navigationController?.topViewController is SearchGameViewController)
//        XCTAssertEqual((viewController.navigationController?.topViewController as! SearchGameViewController).gamesURL, Constants.Endpoints.browserGamesURL)
//    }
//    
//    func testShowError() {
//        // Arrange
//        let errorMessage = "Test Error"
//        mockDelegate.show(error: errorMessage)
//        
//        // Act
//        viewController.show(error: errorMessage)
//        
//        // Assert
//        XCTAssertTrue(mockDelegate.showErrorCalled)
//        XCTAssertEqual(mockDelegate.errorMessage, errorMessage)
//    }
//}
