//
//  TaskTests.swift
//  ToDoTDDAppTests
//
//  Created by Zaki on 15.08.2023.
//

import XCTest
@testable import ToDoTDDApp

final class TaskTests: XCTestCase {

    func testInitTaskWithTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task)
    }
    
    func testInitTaskWithTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertNotNil(task)
    }
    
    func testWhenGivenTitleSetsTitle() {
        let task = Task(title: "Bar")
        
        XCTAssertEqual(task.title, "Bar")
    }
    
    func testWhenGivenDescriptionSetsDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertTrue(task.description == "Bar")
    }
    
    func testTaskInitWithData() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task.date)
    }
    
    func testWhenGivenLocationSetsLocation() {
        let location = Location(name: "Baz")
        let task = Task(title: "Foo", description: "Bar", location: location)
        
        XCTAssertEqual(location, task.location)
        
    }

}
