//
//  NewTaskViewControllerTests.swift
//  ToDoTDDAppTests
//
//  Created by Zaki on 21.08.2023.
//

import XCTest
import CoreLocation
@testable import ToDoTDDApp
import MapKit


final class NewTaskViewControllerTests: XCTestCase {

    var sut: NewTaskViewController!
    var placemark: MockCLPlacemark!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
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
        let mockGeocoder = MockCLGeocoder()
        sut.geocoder = mockGeocoder
        sut.save()
        
        let coordinate = CLLocationCoordinate2D(latitude: 43.2585092, longitude: 76.9249928)
        let location = Location(name: "Bar", coordinate: coordinate)
        let generatedTask = Task(title: "Foo", description: "Baz", date: date, location: location)
        
    
        
        placemark = MockCLPlacemark(mockCoordinate: coordinate)
        mockGeocoder.completionHandler?([placemark], nil)
        
        let task = sut.taskManager.task(at: 0)
        
        XCTAssertEqual(task, generatedTask)
    }
    
    func testSaveButtonHasSaveMethod() {
        let saveButton = sut.saveButton
        
        guard let actions = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(actions.contains("save"))
    }
    
    func testGeocoderFetchesCorrectCoordinates() {
        let geocoderAnswer = expectation(description: "Geocoder answer")
        let addressString = "Алматы"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { placemarks, error in
            let placemark = placemarks?.first
            let location = placemark?.location
            
            guard let latitude = location?.coordinate.latitude, let longitude = location?.coordinate.longitude else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(latitude, 43.2585092)
            XCTAssertEqual(longitude, 76.9249928)
            geocoderAnswer.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSaveDismissNewTaskViewController() {
        let mockNewTaskViewController = MockNewTaskViewController()
        mockNewTaskViewController.titleTextField = UITextField()
        mockNewTaskViewController.titleTextField.text = "Foo"
        mockNewTaskViewController.descriptionTextField = UITextField()
        mockNewTaskViewController.descriptionTextField.text = "Bar"
        mockNewTaskViewController.locationTextField = UITextField()
        mockNewTaskViewController.locationTextField.text = "Baz"
        mockNewTaskViewController.addressTextField  = UITextField()
        mockNewTaskViewController.addressTextField.text = "Алматы"
        mockNewTaskViewController.dateTextField = UITextField()
        mockNewTaskViewController.dateTextField.text = "21.08.23"
        
        mockNewTaskViewController.save()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            XCTAssertTrue(mockNewTaskViewController.isDismissed)
        }
    }
}

extension NewTaskViewControllerTests {
    class MockCLGeocoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    
    class MockCLPlacemark: CLPlacemark {
    
        var mockCoordinate: CLLocationCoordinate2D!
        
        init(mockCoordinate: CLLocationCoordinate2D) {
                let mockLocation = CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
                
                super.init(placemark: MKPlacemark(coordinate: mockLocation.coordinate))
                
                self.mockCoordinate = mockCoordinate
            }
            
            // Required initializer to satisfy the 'init(coder:)' requirement
            required init(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        
        override var location: CLLocation? {
            return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
        }
        
    }
}

extension NewTaskViewControllerTests {
    class MockNewTaskViewController: NewTaskViewController {
        var isDismissed = false
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            isDismissed = true
        }
    }
}

