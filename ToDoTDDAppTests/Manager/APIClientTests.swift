//
//  APIClientTests.swift
//  ToDoTDDAppTests
//
//  Created by Zaki on 22.08.2023.
//

import XCTest
@testable import ToDoTDDApp

final class APIClientTests: XCTestCase {

    var sut: APIClient!
    var mockURLSession: MockURLSession!
    
    override func setUpWithError() throws {
        mockURLSession = MockURLSession()
        sut = APIClient()
        sut.urlSession = mockURLSession
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func userLogin() {
        let completionHandler = {(token: String?, error: Error?) in}
        sut.login(withName: "name", password: "qwerty", completionHandler: completionHandler)
    }

    func testLoginUsesCorrectHost() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.host, "todoapp.com")
    }
    
    func testLoginUsesCorrectPath() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/login")
    }

}

extension APIClientTests {
    class MockURLSession: URLSessionProtocol {
        var url: URL?
        
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}
