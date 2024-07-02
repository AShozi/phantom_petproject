//
//  URLSessionExtensionTests.swift
//  phantomgamesTests
//
//  Created by Aphiwe Shozi on 2024/07/01.
//

import XCTest
@testable import phantomgames

class URLSessionExtensionTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession.shared
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testRequestSuccess() {
        let endpoint = "https://www.freetogame.com/api/games"
        let expectation = expectation(description: "API request should succeed")
        sessionUnderTest.request(endpoint: endpoint, method: .GET) { (result: Result<[Game], APIError>) in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request should not fail: \(error)")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRequestFailure() {
        let endpoint = "invalidURL"
        sessionUnderTest.request(endpoint: endpoint, method: .GET) { (result: Result<[Game], APIError>) in
            switch result {
            case .success:
                XCTFail("Request should fail")
            case .failure(let error):
                XCTAssertEqual(error, .serverError)
            }
        }
    }
}
