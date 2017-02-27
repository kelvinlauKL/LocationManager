//
//  LocationManager.swift
//  LocationManager
//
//  Created by Kelvin Lau on 2017-02-27.
//  Copyright © 2017 MealButlerClub. All rights reserved.
//

import CoreLocation

final class LocationManager: NSObject {
  enum LocationResult {
    case success(latitude: Double, longitude: Double)
    case failure(reason: String)
  }
  
  typealias LocationResultHandler = (LocationResult) -> ()
  
  fileprivate let manager: CLLocationManager
  fileprivate var locationHandlers: [LocationResultHandler] = []
  
  override init() {
    manager = CLLocationManager()
    super.init()
    manager.delegate = self
    manager.requestAlwaysAuthorization()
  }
  
  func getCurrentLocation(completion: @escaping LocationResultHandler) {
    locationHandlers.append(completion)
    manager.requestLocation()
  }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let coordinate = locations.first?.coordinate else { return }
    let latitude = coordinate.latitude
    let longitude = coordinate.longitude
    
    locationHandlers.forEach {
      $0(.success(latitude: latitude, longitude: longitude))
    }
    locationHandlers.removeAll()
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    locationHandlers.forEach {
      $0(.failure(reason: error.localizedDescription))
    }
    locationHandlers.removeAll()
  }
}
