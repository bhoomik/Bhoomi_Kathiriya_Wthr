//
//  LocationListVC.swift
//  WeatherApp
//
//  Created by Bhoomi Kathiriya on 11/10/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import UIKit
import CoreLocation

class LocationListVC: UIViewController
{
    
    
    var selCityIndex : Int?
    var locationManager: CLLocationManager!
  //  var arrCityList  = [City]()
    var appDelegate : AppDelegate?

    
    @IBOutlet weak var tblLocationList : UITableView?
 //   private let newsPresenter = NewsPresenter(newsService: NewsService())
    
    override func viewDidLoad()
    {
        self.commonInit()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var objAddLocationVM = AddLocationVM()
        objAddLocationVM.attachView(view: self)
        objAddLocationVM.retrieveData()
    }
    func commonInit()
    {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate

      //  newsPresenter.attachView(view: self)

        self.tblLocationList?.tableFooterView = UIView()
        self.locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        
    }
    
    // MARK: IBAction Methods
    
    @IBAction func btnAddLocationAction()
    {
        
        self.performSegue(withIdentifier: "LocationListToaddLocation", sender: self)
        
    }

    
    
    // MARK: - Memory Management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


    //MARK: Segue Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if (segue.identifier == "LocationListToWeatherDetail")
        {
            let objVC : WeatherDetailVC = segue.destination as! WeatherDetailVC
            
            objVC.objLocation = self.appDelegate?.arrCityList[self.selCityIndex!]
            
         //   objVC.objAssetTask = self.arrEventList?.object(at: self.selEventIndex!) as? MytaskAssetTask
            
          //  objVC.selTemplateIndex = self.selTemplateIndex
            
            
        }
        
    }
}

extension LocationListVC: LocationView
{
   
    func setLocationData(location: [Location])
    {
        print("reload data")
        self.appDelegate?.arrCityList.removeAll()
        self.appDelegate?.arrCityList = location
        self.tblLocationList?.reloadData()
    }

}


extension LocationListVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return self.appDelegate!.arrCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        

            
            let cell : LocationListCell = tableView.dequeueReusableCell(withIdentifier: "LocationListCell") as! LocationListCell
            
            
            let objLocation: Location = self.appDelegate!.arrCityList[indexPath.row]
        
           cell.setupData(objCity: objLocation)
            
            
        
        return cell
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selCityIndex = indexPath.row
        self.performSegue(withIdentifier: "LocationListToWeatherDetail", sender: self)
    }
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
}
extension LocationListVC : CLLocationManagerDelegate
{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // Process Response
            if let error = error {
                print("Unable to Reverse Geocode Location (\(error))")
            } else {
                
             //   print("placemark info",placemarks)
                
                if let placemarks = placemarks, let placemark = placemarks.first {
                  
                    print("city: ",placemark.locality)
                    print("country: ",placemark.country)
                  
                    var strCity : String = ""
                    var strCountry : String = ""
                    
                    if(placemark.locality != nil)
                    {
                        strCity = placemark.locality!
                    }
                    if(placemark.country != nil)
                    {
                        strCountry = placemark.country!
                    }
                    
                    let lat = location.coordinate.latitude
                    let long = location.coordinate.longitude
                    
                    var strLatitude : String = String(format: "%f", location.coordinate.latitude)
                    print("latitude is",strLatitude)
                    var strLongitude : String = String(format: "%f", location.coordinate.longitude)
                    print("longitude is",strLongitude)

                    var strLocationId = String(format: "%@,%@",strLatitude,strLongitude)

                    let dictLocation : NSMutableDictionary = NSMutableDictionary()
                    dictLocation.setValue(strCity, forKey: "city")
                    dictLocation.setValue(strCountry, forKey: "country")

                    dictLocation.setValue(strLatitude, forKey: "latitude")
                    dictLocation.setValue(strLongitude, forKey: "longitude")

                    if(placemark.locality != nil)
                    {
                        var objCity : Location = Location(strCity: strCity, strCountry:strCountry, dictLocation: dictLocation, strLatitude: strLatitude, strLongitude: strLongitude, strLocationId: strLocationId)
                        
                        if (self.appDelegate?.arrCityList.contains(where: { $0.strLocationId == strLocationId }))!
                        {
                            print("location found")
                            // found
                        }
                        else
                        {
                            
                            var objAddLocationVM = AddLocationVM()
                            objAddLocationVM.attachView(view: self)
                            objAddLocationVM.InsertData(objLocation: objCity)
                            
                            self.appDelegate!.arrCityList.append(objCity)
                            
                            self.tblLocationList?.reloadData()

                            print("location not found")
                            // not
                        }
                     //   print("found item count is",foundItems)
                        
                    }
                    //self.city = placemark.locality!
                    
                    //self.country = placemark.country!
                }
            }
        }
        
      /*  let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        self.locationv = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        if myView.isHidden {
            myView.isHidden = false
            myView.camera = camera
        } else {
            myView.animate(to: camera)*/
        }
    }


    
    
    

