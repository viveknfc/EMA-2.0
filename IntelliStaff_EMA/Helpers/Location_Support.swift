//
//  Location_Support.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 01/08/25.
//

import Foundation
import CoreLocation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    var userLocation: CLLocationCoordinate2D?
    var locationError: String?

    private var locationCompletion: ((CLLocationCoordinate2D?) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func fetchUserLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        locationCompletion = completion
        checkAuthorization()
    }

    private func checkAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied, .restricted:
            locationError = "Location permission denied"
            locationCompletion?(nil)
        @unknown default:
            locationError = "Unknown authorization status"
            locationCompletion?(nil)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            locationError = "Unable to get location"
            locationCompletion?(nil)
            return
        }
        userLocation = location.coordinate
        locationCompletion?(location.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = error.localizedDescription
        locationCompletion?(nil)
    }
}

enum LocationService {
    static func getLocation(completion: @escaping (CLLocationCoordinate2D?, String?) -> Void) {
        let manager = LocationManager()
        manager.fetchUserLocation { coordinate in
            if let coordinate = coordinate {
                completion(coordinate, nil)
            } else {
                completion(nil, manager.locationError)
            }
        }
    }
}

