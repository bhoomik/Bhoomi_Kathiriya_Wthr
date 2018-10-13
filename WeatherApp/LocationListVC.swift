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
            
            
        /*    cell.setupData(objEvent: objEvent)
            cell.btnMore?.tag  = indexPath.row
            cell.btnMore?.addTarget(self, action: #selector(moreOptionsButtonClicked(_:)), for: .touchUpInside)
            return cell
            
        
        
        
        var userCredDict : NSMutableDictionary =  NSMutableDictionary()
        userCredDict =  UserDefaults.standard.object(forKey: "UserCred") as! NSMutableDictionary
        
        print("userCreddict is",userCredDict)
        
        
        let strKey : String? = userCredDict.value(forKey: "Email") as? String
        
        self.dictSearchOptions = NSMutableDictionary()
        
        
        if(indexPath.row == 0)
        {
            let cell : EventSearchHeaderCell = tableView.dequeueReusableCell(withIdentifier: "EventSearchHeaderCell") as! EventSearchHeaderCell
            cell.txtSearch?.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "search.png"), for: .normal)
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0)
            button.frame = CGRect(x: 0, y: CGFloat(5), width: CGFloat(30), height: CGFloat(25))
            
            cell.txtSearch?.rightView = button
            cell.txtSearch?.rightViewMode = .always
            cell.txtSearch?.delegate = self
            
            if( UserDefaults.standard.object(forKey: strKey!) != nil)
            {
                
                let dictTemp : NSDictionary = UserDefaults.standard.object(forKey: strKey!) as! NSDictionary
                self.dictSearchOptions =  dictTemp.mutableCopy() as! NSMutableDictionary
                
                if(self.dictSearchOptions.value(forKey: "eventName") != nil)
                {
                    cell.txtSearch?.text =  self.dictSearchOptions.value(forKey: "eventName") as? String
                    
                }
                
            }
            cell.btnSearchReset?.addTarget(self, action: #selector(EventListVC.searchResetButtonClicked(sender:)), for: .touchUpInside)
            
            self.btnSearchReset = cell.btnSearchReset
            self.txtSearch = cell.txtSearch
            self.addDoneButtonOnKeyboardForSearchEventName()
            
            return cell
        }
        
        
        if(indexPath.row == 1)
        {
            let cell : EventSearchSort = tableView.dequeueReusableCell(withIdentifier: "EventSearchSort") as! EventSearchSort
            
            
            //  newestRadioButtonClicked
            
            cell.btnOldestContainer?.addTarget(self, action: #selector(EventListVC.oldestRadioButtonClicked(_:)), for: .touchUpInside)
            
            cell.btnNewesetContainer?.addTarget(self, action: #selector(EventListVC.newestRadioButtonClicked(_:)), for: .touchUpInside)
            
            
            cell.btnDateRangeContainer?.addTarget(self, action: #selector(EventListVC.dateRangeRadioButtonClicked(_:)), for: .touchUpInside)
            
            self.btnDateRangeContainer = cell.btnDateRangeContainer
            self.btnDateRangeRadio = cell.btnDateRangeRadio
            self.btnNewesetContainer  = cell.btnNewesetContainer
            self.btnNewesetRadio = cell.btnNewesetRadio
            
            self.btnOldestContainer  = cell.btnOldestContainer
            self.btnOldestRadio =  cell.btnOldestRadio
            
            
            return cell
        }
        
        
        let cell : EventSearchDateRange = tableView.dequeueReusableCell(withIdentifier: "EventSearchDateRange") as! EventSearchDateRange
        
        if( UserDefaults.standard.object(forKey: strKey!) != nil)
        {
            
            let dictTemp : NSDictionary = UserDefaults.standard.object(forKey: strKey!) as! NSDictionary
            
            self.dictSearchOptions =  dictTemp.mutableCopy() as! NSMutableDictionary
            
            
            let dateFormatter =  DateFormatter()
            
            
            dateFormatter.timeStyle = DateFormatter.Style.none
            
            
            dateFormatter.dateFormat = "MM/dd/yyyy"
            
            if(self.dictSearchOptions.value(forKey: "FromDate") != nil)
            {
                cell.txtFromDate?.text =  self.dictSearchOptions.value(forKey: "FromDate") as? String
                self.strFormDate = self.dictSearchOptions.value(forKey: "FromDate") as? String
                
                self.formDate = dateFormatter.date(from: self.dictSearchOptions.value(forKey: "FromDate") as! String)
                
            }
            if(self.dictSearchOptions.value(forKey: "ToDate") != nil)
            {
                cell.txtToDate?.text =  self.dictSearchOptions.value(forKey: "ToDate") as? String
                self.strToDate = self.dictSearchOptions.value(forKey: "ToDate") as? String
                
                self.toDate = dateFormatter.date(from: self.dictSearchOptions.value(forKey: "ToDate") as! String)
                
                
            }
            
        }
        cell.txtFromDate?.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        cell.txtToDate?.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        
        
        
        self.txtFromDate = cell.txtFromDate
        cell.txtFromDate?.delegate=self
        cell.txtToDate?.delegate=self
        self.txtToDate = cell.txtToDate
        
        self.addDatePickerToFromDate()
        self.addDatePickerToToDate()*/
        
        return cell
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selCityIndex = indexPath.row
        self.performSegue(withIdentifier: "LocationListToWeatherDetail", sender: self)
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


    
    
    

