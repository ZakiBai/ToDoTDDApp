//
//  NewTaskViewControllerTests.swift
//  ToDoTDDAppTests
//
//  Created by Zaki on 21.08.2023.
//

import XCTest
import CoreLocation
@testable import ToDoTDDApp


final class NewTaskViewControllerTests: XCTestCase {

    var sut: NewTaskViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHasTitleTextField() {
        XCTAssertTrue(sut.titleTextField.isDescendant(of: sut.view))
    }
    
    func testHasLocationTextField() {
        XCTAssertTrue(sut.locationTextField.isDescendant(of: sut.view))
    }
    
    func testHasDateTextField() {
        XCTAssertTrue(sut.dateTextField.isDescendant(of: sut.view))
    }
    
    func testHasAdressTextField() {
        XCTAssertTrue(sut.addressTextField.isDescendant(of: sut.view))
    }

    func testHasDescriptionTextField() {
        XCTAssertTrue(sut.descriptionTextField.isDescendant(of: sut.view))
    }
    
    func testHasSaveButton() {
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }

    func testHasCancelButton() {
        XCTAssertTrue(sut.cancelButton.isDescendant(of: sut.view))
    }
    
    func testSaveUsesGeocoderToConvertCoordinateFromAddress() {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = df.date(from: "21.08.23")
        
        sut.titleTextField.text = "Foo"
        sut.locationTextField.text = "Bar"
        sut.dateTextField.text = "21.08.23"
        sut.addressTextField.text = "Алматы"
        sut.descriptionTextField.text = "Baz"
        
        sut.taskManager = TaskManager()
        sut.save()
        
        let task = sut.taskManager.task(at: 0)
        let coordinate = CLLocationCoordinate2D(latitude: 43.2585092, longitude: 76.9249928)
        let location = Location(name: "Bar", coordinate: coordinate)
        let generatedTask = Task(title: "Foo", description: "Baz", date: date, location: location)
        
        XCTAssertEqual(task, generatedTask)
    }
}
