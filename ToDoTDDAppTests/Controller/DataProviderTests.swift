//
//  DataProviderTests.swift
//  ToDoTDDAppTests
//
//  Created by Zaki on 17.08.2023.
//

import XCTest
@testable import ToDoTDDApp

final class DataProviderTests: XCTestCase {
    
    var sut: DataProvider!
    var tableView: UITableView!

    override func setUpWithError() throws {
        sut = DataProvider()
        tableView = UITableView()
        tableView.dataSource = sut
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberOfSectionsIsTwo() {
        let numberOfSections = tableView.numberOfSections
        
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func testNumberOfRowsInSectionZeroIsTaskCount() {
        sut.taskManager = TaskManager()
        sut.taskManager?.add(task: Task(title: "Bar"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.taskManager?.add(task: Task(title: "Baz"))
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
        
    }

}
