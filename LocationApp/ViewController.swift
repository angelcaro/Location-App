//
//  ViewController.swift
//  LocationApp
//
//  Created by Angel Caro on 2/4/16.
//  Copyright © 2016 AngelCaro. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLable: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let userLocation: CLLocation = locations[0]
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        
        self.courseLabel.text =  "\(userLocation.course)"
        self.speedLabel.text = "\(userLocation.speed)"
        
        self.altitudeLable.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                print(error)
                
            } else {
                
                if let p = placemarks?[0] {
                    
                    let subThoroughfare = p.subThoroughfare ?? ""
                    
                    let thoroughfare = p.thoroughfare ?? ""
                    
                    let subLocality = p.subLocality ?? ""
                    
                    let subAdministrativeArea = p.subAdministrativeArea ?? ""
                    
                    let postalCode = p.postalCode ?? ""
                    
                    let country = p.country ?? ""
                    
                    self.addressLabel.text = "\(subThoroughfare) \(thoroughfare) \n \(subLocality) \n \(subAdministrativeArea) \n \(postalCode) \n \(country)"
                    
                }
            }
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

