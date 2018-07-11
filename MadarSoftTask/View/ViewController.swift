//
//  ViewController.swift
//  MadarSoftTask
//
//  Created by Admin on 5/25/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var c: CLLocationManager!
    var lat: Double?{
        didSet{
            loadView()
        }
    }
    var longi: Double?{
        
        didSet{
            loadView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        c = CLLocationManager()
        
        c.desiredAccuracy = kCLLocationAccuracyBest
        c.distanceFilter = kCLLocationAccuracyThreeKilometers
        c.delegate = self
        c.requestAlwaysAuthorization()
        c.startUpdatingLocation()
        
        
        
    }
    
    override func loadView() {
        
        
        getMap()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("dataaa")
        let loc = locations[0]
        lat = loc.coordinate.latitude
        longi = loc.coordinate.longitude
        
        
    }
    
    func getMap(){
        
        if(lat != nil && longi != nil){
            let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: longi!, zoom: 6.0)
            
            let mapView = GMSMapView.map(withFrame: self.view.bounds , camera: camera)
            
            view = mapView
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: longi!)
            
            marker.title = "You"
            marker.snippet = "Your Current Location"
            marker.icon = GMSMarker.markerImage(with: UIColor.red)
            marker.map = mapView
            
            let button = UIButton(frame: CGRect.init(x: mapView.bounds.size.width-155, y: mapView.bounds.size.height-50, width: 90, height: 40))
            button.backgroundColor = UIColor.black
            button.setTitle("Banks", for: UIControlState.normal)
            
            
            button.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
            
            let button2 = UIButton(frame: CGRect.init(x: 65, y: mapView.bounds.size.height-50, width: 90, height: 40))
            button2.backgroundColor = UIColor.black
            button2.setTitle("Mosques", for: UIControlState.normal)
            
            
            button2.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
            
            mapView.addSubview(button)
            mapView.addSubview(button2)
            
            
            
            
        }else{
            
            let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 6.0)
            
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            
            view = mapView
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            
            marker.title = "Sydney"
            marker.snippet = "Australia"
            marker.map = mapView
            
        }
        
    }
    
    @objc func btnAction(sender: UIButton!){
        let g:GoogleMapsClient = GoogleMapsClient()
        g.getPlaces(latitude: lat!, longitude: longi!, type: "bank", distance: 5000)
    }
    
    
}

