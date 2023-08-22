//
//  SceneDelegate.swift
//  Hopper
//
//  Created by Rowen Link on 8/16/23.
//

import Foundation
import UIKit
import SwiftUI
import CoreLocation

class AlertSettings: ObservableObject {
    @Published var showAlert = false
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate, ObservableObject {

    var window: UIWindow?
    var settings = AlertSettings()
    let locationManager = CLLocationManager()
    private var barData = barViewModel()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = ContentView()
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView:  contentView.environmentObject(settings))
            self.window = window
            window.makeKeyAndVisible()
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 4.0
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = false
        locationManager.requestAlwaysAuthorization()
        
        barData.fetchDataForUsage { result in
            switch result {
            case .success(let fetchedBars):
                print("Fetched bars:", fetchedBars)
                for bar in fetchedBars{
                    self.monitorRegionAtLocation(center: bar.coordinates, identifier: bar.id)
                }
            case .failure(let error):
                print("Error fetching bars:", error)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    
    func monitorRegionAtLocation(center: CLLocationCoordinate2D, identifier: String) {
            if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
                print("starting to track " + identifier)
                let region = CLCircularRegion(center: center,
                     radius: 50, identifier: identifier)
                region.notifyOnEntry = true
                region.notifyOnExit = true
                locationManager.startMonitoring(for: region)
            }
     }
}

extension SceneDelegate : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("entered worked for : " + region.identifier)
        // User entered a monitored region
        barData.updateNumUsers(for: region.identifier, increment: true)
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exit worked for : " + region.identifier)
        // User exited a monitored region
        barData.updateNumUsers(for: region.identifier, increment: false)

    }
}
