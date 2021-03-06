//
//  AddLocationVC.swift
//  WeatherApp
//
//  Created by Bhoomi Kathiriya on 12/10/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddLocationVC: UIViewController,UIGestureRecognizerDelegate,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()

    var appDelegate : AppDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func commonInit()
    {
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        mapView.delegate = self
        mapView.showsUserLocation = true
      
        /*locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }*/

        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureReconizer:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)

    }
    

  /*  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        region.center = mapView.userLocation.coordinate
        mapView.setRegion(region, animated: true)
    }*/
    
    //MARK: Gesture Recognizor Methods
    
    @objc func handleTap(gestureReconizer: UILongPressGestureRecognizer) {
        
        print("handle tap")
        let location = gestureReconizer.location(in: mapView)
        let coordinate  = mapView.convert(location,toCoordinateFrom: mapView)
        let coordinate2  = mapView.convert(location,toCoordinateFrom: mapView) as CLLocationCoordinate2D

        let getLat: CLLocationDegrees = coordinate2.latitude
        let getLon: CLLocationDegrees = coordinate2.longitude
        
        let strLatitude : String = String(format: "%f", coordinate2.latitude)
        print("latitude is",strLatitude)
        let strLongitude : String = String(format: "%f", coordinate2.longitude)
        print("longitude is",strLongitude)

        
        let mapLocation: CLLocation =  CLLocation(latitude: getLat, longitude: getLon)

        var strCity : String = ""
        var strCountry : String = ""
        var strLocationId : String = ""
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(mapLocation) { (placemarks, error) in
            // Process Response
            if let error = error {
                print("Unable to Reverse Geocode Location (\(error))")
            } else {
                if let placemarks = placemarks, let placemark = placemarks.first {
                    
                  //  print("city: ",placemark.locality)
                   // print("country: ",placemark.country)
                    
                    if(placemark.locality != nil)
                    {
                        strCity = placemark.locality!
                    }
                    if(placemark.country != nil)
                    {
                        strCountry = placemark.country!
                    }
                    strLocationId = String(format: "%@,%@",strLatitude,strLongitude)

                    let dictLocation : NSMutableDictionary = NSMutableDictionary()
                    dictLocation.setValue(strCity, forKey: "city")
                    dictLocation.setValue(strCountry, forKey: "country")
                    
                    dictLocation.setValue(strLatitude, forKey: "latitude")
                    dictLocation.setValue(strLongitude, forKey: "longitude")
                    dictLocation.setValue(strLocationId, forKey: "locationId")

                    if(placemark.locality != nil ||  placemark.country != nil)
                    {
                        let objCity : Location = Location(strCity: strCity, strCountry:strCountry, dictLocation: dictLocation, strLatitude: strLatitude, strLongitude: strLongitude, strLocationId: strLocationId)
                        
                        let objAdletcationVM = AddLocationVM()
                        print("insert data")
                        objAdletcationVM.InsertData(objLocation: objCity)
                        
                       // self.appDelegate!.arrCityList.append(objCity)
                        
                    }
                }
            }
        }
        
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        
    }

    
    //MARK: Memory Management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBAction Methods
    
    @IBAction func btnBackAction()
    {
       self.navigationController?.popViewController(animated: true)
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
