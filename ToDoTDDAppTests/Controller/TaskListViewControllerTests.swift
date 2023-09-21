//
//  TaskListViewControllerTests.swift
//  ToDoTDDAppTests
//
//  Created by Zaki on 17.08.2023.
//

import XCTest
@testable import ToDoTDDApp
final class TaskListViewControllerTests: XCTestCase {
    var sut: TaskListViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
        sut = vc as? TaskListViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }

    func testWhenViewIsLoadedTableViewNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testWhenViewIsLoadedDataProviderIsNotNil() {
        XCTAssertNotNil(sut.dataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDelegateIsSet() {
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDelegateEqualsTableViewDataSource() {
        XCTAssertEqual(sut.tableView.dataSource as? DataProvider, sut.tableView.delegate as? DataProvider)
    }
    
    func testTaskListViewControllerHasAssBarButtonWithSelfAsTarget() {
        let target = sut.navigationItem.rightBarButtonItem?.target
        XCTAssertEqual(target as? TaskListViewController, sut)
    }
    
    func presentingNewTaskViewController() -> NewTaskViewController {
        
        guard let newTaskButton = sut.navigationItem.rightBarButtonItem, let action = newTaskButton.action else {
            XCTFail()
            return NewTaskViewController()
        }
        
        UIApplication.shared.keyWindow?.rootViewController = sut
        
        sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
       
        let newTaskViewController = sut.presentedViewController as! NewTaskViewController
        return newTaskViewController
    }
    
    func testAddNewTaskPresentsNewTaskViewController() {
        let newTaskViewController = presentingNewTaskViewController()
        XCTAssertNotNil(newTaskViewController.titleTextField)
    }
    
    func testSharesSameTaskManagerWithNewTaskVC() {
        let newTaskViewController = presentingNewTaskViewController()
        XCTAssertTrue(newTaskViewController.taskManager === sut.dataProvider.taskManager)
    }
    
    func testWhenViewAppearedTableViewReloaded() {
        let mockTableView = MockTableView()
        sut.tableView = mockTableView
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertTrue((sut.tableView as! MockTableView).isReloaded)
    }

}

extension TaskListViewControllerTests {
    class MockTableView: UITableView {
        var isReloaded = false
        override func reloadData() {
            isReloaded = true
        }
    }
}
