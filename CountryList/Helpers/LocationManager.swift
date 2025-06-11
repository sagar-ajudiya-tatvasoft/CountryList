//
//  LocationManager.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    
    @Published var countryName: String = .india {
        didSet {
            onCountryDetected?(countryName)
        }
    }
    var onCountryDetected: ((String) -> Void)?
    
    // MARK: - Init
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        requestPermission()
    }
    
    // Request Permission
    func requestPermission() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied, .restricted:
            setDefaultCountry()
        default:
            break
        }
    }
    
    private func setDefaultCountry() {
        countryName = .india
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.requestLocation()
        } else if status == .denied || status == .restricted {
            setDefaultCountry()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            setDefaultCountry()
            return
        }
        
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self else { return }
            
            if error != nil {
                setDefaultCountry()
                return
            }
            
            let country = placemarks?.first?.country
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                countryName = country ?? .india
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        setDefaultCountry()
    }
}
