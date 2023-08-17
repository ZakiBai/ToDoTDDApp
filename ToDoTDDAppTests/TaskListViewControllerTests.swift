//
//  TaskListViewControllerTests.swift
//  ToDoTDDAppTests
//
//  Created by Zaki on 17.08.2023.
//

import XCTest
@testable import ToDoTDDApp
final class TaskListViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableViewNotNilWhenViewIsLoaded() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
        let sut = vc as! TaskListViewController
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView)
        
        
    }

}
