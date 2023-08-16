//
//  TaskManagerTests.swift
//  ToDoTDDAppTests
//
//  Created by Zaki on 16.08.2023.
//

import XCTest
@testable import ToDoTDDApp

final class TaskManagerTests: XCTestCase {
    var sut: TaskManager!
    
    override func setUpWithError() throws {
        sut = TaskManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testInitTaskManagerWithZeroTasks() {
        XCTAssertEqual(sut.tasksCount, 0)
    }

    func testInitTaskManagerWithZeroDoneTasks() {
        XCTAssertEqual(sut.doneTasksCount, 0)
    }
    
    func testAddTaskIncrementTasksCount() {
        let task = Task(title: "Bar")
        
        sut.add(task: task)
        
        XCTAssertEqual(sut.tasksCount, 1)
    }
    
    func testTaskAtIndexIsAddedTask() {
        let task = Task(title: "Bar")
        
        sut.add(task: task)
        
        let returnedTask = sut.task(at: 0)
        
        XCTAssertEqual(task.title, returnedTask.title)
    }
    
    func testCheckTaskAtIndexChangesCount() {
        let task = Task(title: "Bar")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.tasksCount, 0)
        XCTAssertEqual(sut.doneTasksCount, 1)
    }
    
    func testCheckedTaskRemovedFromTasks() {
        let taskOne = Task(title: "Bar")
        let taskTwo = Task(title: "Baz")
        sut.add(task: taskOne)
        sut.add(task: taskTwo)
        
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.task(at: 0).title, "Baz")
    }
    
    func testDoneTaskAtReturnsCheckedTask() {
        let task = Task(title: "Bar")
        sut.add(task: task)
        sut.checkTask(at: 0)
        
        let returnedTask = sut.doneTask(at: 0)
        
        XCTAssertEqual(task.title, returnedTask.title)
    }
}
