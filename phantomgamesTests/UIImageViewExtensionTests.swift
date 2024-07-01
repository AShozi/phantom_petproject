//
//  UIImageViewExtensionTests.swift
//  phantomgamesTests
//
//  Created by Aphiwe Shozi on 2024/07/01.
//

import XCTest
@testable import phantomgames

class UIImageViewExtensionTests: XCTestCase {

    var imageView: UIImageView!
    
    override func setUp() {
        super.setUp()
        imageView = UIImageView()
    }
    
    override func tearDown() {
        imageView = nil
        super.tearDown()
    }

    func testImageDownloadFromURL() {
        let imageURL = URL(string: "https://via.placeholder.com/150")!
        let expectation = expectation(description: "Image should be downloaded")
        imageView.downloaded(from: imageURL)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertNotNil(self.imageView.image)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testImageDownloadFromInvalidURL() {
        let invalidURL = "invalidURL"
        imageView.downloaded(from: invalidURL)
        XCTAssertNil(imageView.image)
    }
}
