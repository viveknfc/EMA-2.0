//
//  Location_Support.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 01/08/25.
//

import Foundation
import CoreLocation

//@Observable
//class LocationManager: NSObject, CLLocationManagerDelegate {
//    private let locationManager = CLLocationManager()
//
//    var userLocation: CLLocationCoordinate2D?
//    var locationError: String?
//
//    private var locationCompletion: ((CLLocationCoordinate2D?) -> Void)?
//
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//
//    func fetchUserLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
//        locationCompletion = completion
//        checkAuthorization()
//    }
//
//    private func checkAuthorization() {
//        switch locationManager.authorizationStatus {
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .authorizedWhenInUse, .authorizedAlways:
//            locationManager.requestLocation()
//        case .denied, .restricted:
//            locationError = "Location permission denied"
//            locationCompletion?(nil)
//        @unknown default:
//            locationError = "Unknown authorization status"
//            locationCompletion?(nil)
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else {
//            locationError = "Unable to get location"
//            locationCompletion?(nil)
//            return
//        }
//        userLocation = location.coordinate
//        locationCompletion?(location.coordinate)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        locationError = error.localizedDescription
//        locationCompletion?(nil)
//    }
//}
//
//enum LocationService {
//    static func getLocation(completion: @escaping (CLLocationCoordinate2D?, String?) -> Void) {
//        let manager = LocationManager()
//        manager.fetchUserLocation { coordinate in
//            if let coordinate = coordinate {
//                completion(coordinate, nil)
//            } else {
//                completion(nil, manager.locationError)
//            }
//        }
//    }
//}
//



 
import CoreLocation
 
class SimpleLocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var completion: ((CLLocationCoordinate2D?, Error?) -> Void)?
    private var addressCompletion: ((String?, Error?) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // MARK: - Closure based
    func requestLocation(completion: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
        self.completion = completion
        
        let status = manager.authorizationStatus
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.requestLocation()
        } else {
            completion(nil, NSError(domain: "LocationError",
                                    code: 1,
                                    userInfo: [NSLocalizedDescriptionKey: "Permission denied"]))
        }
    }
    
    // MARK: - Async/await support
    func getLocation() async throws -> CLLocationCoordinate2D {
        try await withCheckedThrowingContinuation { continuation in
            requestLocation { coordinate, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let coordinate = coordinate {
                    continuation.resume(returning: coordinate)
                } else {
                    continuation.resume(throwing: NSError(
                        domain: "LocationError",
                        code: 2,
                        userInfo: [NSLocalizedDescriptionKey: "Unknown location error"]
                    ))
                }
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        completion?(locations.last?.coordinate, nil)
        completion = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(nil, error)
        completion = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse ||
            manager.authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        }
    }
    
    func getAddress() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            requestAddress { address, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let address = address {
                    continuation.resume(returning: address)
                } else {
                    continuation.resume(throwing: NSError(
                        domain: "LocationError",
                        code: 3,
                        userInfo: [NSLocalizedDescriptionKey: "Unknown address error"]
                    ))
                }
            }
        }
    }
    
    // MARK: - Request Full Address
    func requestAddress(completion: @escaping (String?, Error?) -> Void) {
        self.addressCompletion = completion
        requestLocation { [weak self] coordinate, error in
            if let error = error {
                completion(nil, error)
            } else if let coordinate = coordinate {
                self?.reverseGeocode(coordinate: coordinate, completion: completion)
            }
        }
    }
    
    private func reverseGeocode(coordinate: CLLocationCoordinate2D, completion: @escaping (String?, Error?) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                completion(nil, error)
            } else if let placemark = placemarks?.first {
                var address = ""
                if let name = placemark.name { address += name + ", " }
                if let locality = placemark.locality { address += locality + ", " }
                if let administrativeArea = placemark.administrativeArea { address += administrativeArea + ", " }
                if let postalCode = placemark.postalCode { address += postalCode + ", " }
                if let country = placemark.country { address += country }
                
                completion(address.trimmingCharacters(in: .whitespacesAndNewlines), nil)
            } else {
                completion(nil, NSError(domain: "LocationError",
                                        code: 2,
                                        userInfo: [NSLocalizedDescriptionKey: "Address not found"]))
            }
        }
    }
    
    
}

 

 
