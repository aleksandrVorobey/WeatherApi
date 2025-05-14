//
//  LocationManager.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//


import CoreLocation

final class LocationManager: NSObject {
    
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    private var completion: ((Result<LocationCoordinate, Error>) -> Void)?
    
    private var didRequestAuthorization = false
    private let defaultLocation = LocationCoordinate(latitude: 55.7558, longitude: 37.6173) 

    private override init() {
        super.init()
        locationManager.delegate = self
    }

    func getUserLocation(completion: @escaping (Result<LocationCoordinate, Error>) -> Void) {
        self.completion = completion
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            didRequestAuthorization = true
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied, .restricted:
            completion(.success(defaultLocation))
        @unknown default:
            completion(.success(defaultLocation))
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.first else {
            completion?(.success(defaultLocation))
            completion = nil
            return
        }
        completion?(.success(LocationCoordinate(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)))
        completion = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.success(defaultLocation))
        completion = nil
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        } else if status == .denied || status == .restricted {
            if didRequestAuthorization {
                completion?(.success(defaultLocation))
                completion = nil
            }
        }
    }
}
