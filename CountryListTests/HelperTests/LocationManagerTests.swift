//
//  LocationManagerTests.swift
//  CountryListTests
//
//  Created by MACM06 on 12/06/25.
//

import XCTest
import CoreLocation
@testable import CountryList

final class LocationManagerTests: XCTestCase {
    
    func test_WhenLocationAccessDenied_ShouldSetDefaultCountry() {
        let mock = MockCLLocationManager()
        mock.mockAuthorizationStatus = .denied
        
        let manager = LocationManager(locationManager: mock)
        
        XCTAssertEqual(manager.countryName, .india)
    }
    
    func test_WhenValidLocationIsReturned_ShouldSetCountryName() {
        let expectation = self.expectation(description: "Country name updated")
        
        let mock = MockCLLocationManager()
        mock.mockAuthorizationStatus = .authorizedWhenInUse
        mock.mockLocation = CLLocation(latitude: 28.6139, longitude: 77.2090)
        
        let locationManager = LocationManager(locationManager: mock)
        locationManager.onCountryDetected = { name in
            XCTAssertNotNil(name)
            expectation.fulfill()
        }
        
        mock.requestLocation()
        waitForExpectations(timeout: 3)
    }
    
    func test_WhenLocationFails_ShouldSetDefaultCountry() {
        let mock = MockCLLocationManager()
        mock.mockAuthorizationStatus = .authorizedWhenInUse
        mock.mockLocation = nil
        
        let manager = LocationManager(locationManager: mock)
        
        XCTAssertEqual(manager.countryName, .india)
    }
}
