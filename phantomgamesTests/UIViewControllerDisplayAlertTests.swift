//
//  UIViewControllerDisplayAlertTests.swift
//  phantomgamesTests
//
//  Created by Aphiwe Shozi on 2024/07/01.
//

import XCTest
@testable import phantomgames

class UIViewControllerDisplayAlertTests: XCTestCase {
    
    var mockViewController: MockViewController!
    
    override func setUp() {
        super.setUp()
        mockViewController = MockViewController()
    }
    
    override func tearDown() {
        mockViewController = nil
        super.tearDown()
    }
    
    class MockViewController: UIViewController {
        
        var presentCalled = false
        var presentedAlert: UIAlertController?
        
        override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            presentCalled = true
            presentedAlert = viewControllerToPresent as? UIAlertController
        }
    }
    
    func testDisplayAlertSuccess() {
        let title = "Test Title"
        let message = "Test Message"
        let buttonTitle = "OK"
        mockViewController.displayAlert(title: title, message: message, buttonTitle: buttonTitle)
        XCTAssertTrue(mockViewController.presentCalled, "present(_:animated:completion:) should be called")
        XCTAssertNotNil(mockViewController.presentedAlert, "UIAlertController should be presented")
        XCTAssertEqual(mockViewController.presentedAlert?.title, title, "Alert title should match")
        XCTAssertEqual(mockViewController.presentedAlert?.message, message, "Alert message should match")
        let actions = mockViewController.presentedAlert?.actions
        XCTAssertEqual(actions?.count, 1, "Alert should have one action")
        XCTAssertEqual(actions?.first?.title, buttonTitle, "Action button title should match")
        XCTAssertEqual(actions?.first?.style, .default, "Action button style should be default")
    }
    
}
