//
//  LocationTests.swift
//  ToDoTDDAppTests
//
//  Created by Zaki on 16.08.2023.
//

import XCTest
import CoreLocation
@testable import ToDoTDDApp

final class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLocationSetsName() {
        let location = Location(name: "Bar")
        XCTAssertEqual(location.name, "Bar")
    }
    
    func testInitSetsCoordinates() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        
        let location = Location(name: "Bar", coordinate: coordinate)
        
        XCTAssertEqual(coordinate.longitude, location.coordinate?.longitude)
        XCTAssertEqual(coordinate.latitude, location.coordinate?.latitude)
        
    }

}
