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
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func getUserLocation(completion: @escaping (Result<LocationCoordinate, Error>) -> Void) {
        self.completion = completion
        let status = locationManager.authorizationStatus
        
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        } else {
            completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Location access denied"])))
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.first else { return }
        completion?(.success(LocationCoordinate(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)))
        completion = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(error))
        completion = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
}
