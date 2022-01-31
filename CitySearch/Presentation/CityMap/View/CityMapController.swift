//
//  CityMapController.swift
//  CitySearch
//
//  Created by Gayan Dias on 31/01/2565 BE.
//

import UIKit
import MapKit

class CityMapController: UIViewController {
    
    @IBOutlet weak var cityMapView: MKMapView!
    var locationManager: CLLocationManager!
    var viewModel: CityMapViewModel = CityMapViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "\(self.viewModel.city!.name), \(self.viewModel.city!.country)"
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        self.addPin(title: "\(self.viewModel.city!.name), \(self.viewModel.city!.country)", coord: self.viewModel.city!.coord)
        self.focusMapView(coord: self.viewModel.city!.coord)
    }
    
    private func addPin(title: String, coord: Coordinate) {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: coord.lat, longitude: coord.lon)
        annotation.coordinate = centerCoordinate
        annotation.title = title
        self.cityMapView.addAnnotation(annotation)
    }

    private func focusMapView(coord: Coordinate) {
        let mapCenter = CLLocationCoordinate2DMake(coord.lat, coord.lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: span)
        self.cityMapView.region = region
    }
}

extension CityMapController: CLLocationManagerDelegate {
    // iOS 14
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .notDetermined:
                print("Not determined")
            case .restricted:
                print("Restricted")
            case .denied:
                print("Denied")
            case .authorizedAlways:
                print("Authorized Always")
            case .authorizedWhenInUse:
                print("Authorized When in Use")
            @unknown default:
                print("Unknown status")
            }
        }
    }
    
    // iOS 13 and below
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("Not determined")
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways:
            print("Authorized Always")
        case .authorizedWhenInUse:
            print("Authorized When in Use")
        @unknown default:
            print("Unknown status")
        }
    }
}
