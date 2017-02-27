//
//  ViewController.swift
//  LocationManager
//
//  Created by Kelvin Lau on 2017-02-27.
//  Copyright © 2017 MealButlerClub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let locationManager = LocationManager()
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    locationManager.getCurrentLocation { result in
      switch result {
      case let .success(latitude, longitude):
        print("Latitude: \(latitude), Longitude: \(longitude)")
      case .failure(let reason):
        print("Failed to get location: \(reason)")
      }
    }
  }
}

