//
//  LocationService.swift
//  sweetRain
//
//  Created by JINHUN CHOI on 2023/12/20.
//

import UIKit

import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    var currentLocation: Observable<(Double, Double)> = Observable((0,0))

    let locationManager = CLLocationManager()

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        let status = locationManager.authorizationStatus
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Success")
        case .denied, .restricted, .notDetermined:
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { success in
                    print("Settings opened: \(success)")
                })
            }
        default:
            break
        }
    }
    
    func startUpdating() {
            locationManager.startUpdatingLocation()
        }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation.value = (location.coordinate.latitude, location.coordinate.longitude)
            locationManager.stopUpdatingLocation()
        }
    }
}
