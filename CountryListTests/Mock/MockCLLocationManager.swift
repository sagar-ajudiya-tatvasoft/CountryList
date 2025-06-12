//
//  MockCLLocationManager.swift
//  CountryListTests
//
//  Created by MACM06 on 12/06/25.
//

import Foundation
import CoreLocation

class MockCLLocationManager: CLLocationManager {
    var mockAuthorizationStatus: CLAuthorizationStatus = .authorizedWhenInUse
    var mockLocation: CLLocation?
    
    override var authorizationStatus: CLAuthorizationStatus {
        return mockAuthorizationStatus
    }

    override func requestWhenInUseAuthorization() {
        delegate?.locationManagerDidChangeAuthorization?(self)
    }

    override func requestLocation() {
        if let location = mockLocation {
            delegate?.locationManager?(self, didUpdateLocations: [location])
        } else {
            delegate?.locationManager?(self, didFailWithError: NSError(domain: "NoLocation", code: 1, userInfo: nil))
        }
    }
}
