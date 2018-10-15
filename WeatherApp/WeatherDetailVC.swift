//
//  WeatherDetailVC.swift
//  WeatherApp
//
//  Created by Bhoomi Kathiriya on 13/10/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class CollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!


}


extension WeatherDetailVC : LocationView
{
    
    func setWeatherInfo(objWeatherInfo : WeatherInfo)
    {
        self.objWeatherInfo = objWeatherInfo
        DispatchQueue.main.async { () -> Void in
            
            self.lblLocation?.text = String(format: "%@ ,%@",(self.objWeatherInfo?.strCityName)!, objWeatherInfo.strCountryName!)
            self.collectionView.reloadData()
        }
        print("update weather Info")
    }
    
func setWeeklyForecastData(arrWeatherInfo: [WeatherInfo])
{
        print("set weekly data",arrWeatherInfo)
      //  self.appDelegate?.arrCityList.removeAll()
       // self.appDelegate?.arrCityList = location
    self.arrWeeklyForCast.removeAll()
    self.arrWeeklyForCast = arrWeatherInfo
        DispatchQueue.main.async { () -> Void in

        self.tblWeeklyForeCast?.reloadData()
        }
    }
    func startLoading() {
        self.activityIndicator.show()
    }
    
    func finishLoading()
    {
        self.activityIndicator.hide()
        
    }
    
    
}


class WeatherDetailVC: UIViewController {

    let reuseIdentifier = "collectionViewCellId"
    
    let activityIndicator = ActivityIndicator()

    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrTitleImage : NSMutableArray? = NSMutableArray()
    var objLocation : Location?
    var objWeatherInfo : WeatherInfo?
    var arrWeeklyForCast = [WeatherInfo]()
    @IBOutlet weak var tblWeeklyForeCast: UITableView!

    var strUnit : String  = "Metric"
    @IBOutlet weak var lblLocation : UILabel?
    
    @IBOutlet weak var btnCelcisus : UIButton?
    @IBOutlet weak var btnFaherenhit : UIButton?

    private let locaionPresenter = LocationPresenter(locationService: LocationService())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
        // Do any additional setup after loading the view.
    }

    func commonInit()
    {
        tblWeeklyForeCast.tableFooterView=UIView()
        if(UserDefaults.standard.object(forKey: "Unit") != nil)
        {
            self.strUnit = UserDefaults.standard.object(forKey: "Unit") as! String
            if(self.strUnit == "Metric")
            {
                btnFaherenhit?.isSelected = false
                btnCelcisus?.isSelected = true
            }
            else
            {
                btnFaherenhit?.isSelected = true
                btnCelcisus?.isSelected = false
                
            }
            
        }
        else
        {
            btnFaherenhit?.isSelected = false
            btnCelcisus?.isSelected = true
            
        }
        self.tblWeeklyForeCast.layer.masksToBounds = true
        self.tblWeeklyForeCast.layer.cornerRadius = 10
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.isHidden = true
        locaionPresenter.attachView(view:self)
        
        let dictTemp : NSMutableDictionary = NSMutableDictionary()
        dictTemp.setValue("Temperature", forKey: "title")
        dictTemp.setValue("temp.png", forKey: "image")

        self.arrTitleImage?.add(dictTemp)
        
        let dictHumidity : NSMutableDictionary = NSMutableDictionary()
        dictHumidity.setValue("Humidity", forKey: "title")
        dictHumidity.setValue("humidity", forKey: "image")

        self.arrTitleImage?.add(dictHumidity)
        
        
        let dictRainC : NSMutableDictionary = NSMutableDictionary()
        dictRainC.setValue("Rain", forKey: "title")
        dictRainC.setValue("rain", forKey: "image")

        self.arrTitleImage?.add(dictRainC)
        
        let dictWind : NSMutableDictionary = NSMutableDictionary()
        dictWind.setValue("Wind", forKey: "title")
        dictWind.setValue("wind", forKey: "image")

        self.arrTitleImage?.add(dictWind)
        
        self.collectionView.reloadData()

        self.collectionView.layer.masksToBounds = true
        self.collectionView.layer.cornerRadius = 10
        locaionPresenter.getLocationData(objLocation: self.objLocation!, strUnit: self.strUnit)
        locaionPresenter.getWeeklyForecastData(objLocation: self.objLocation!, strUnit: self.strUnit)

        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: IBAction Methods
    
    @IBAction func btnBackAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnCelciusAction()
    {
        self.strUnit  = "Metric"
        UserDefaults.standard.set(self.strUnit, forKey: "Unit")
        UserDefaults.standard.synchronize()
        self.btnCelcisus?.isSelected = true
        self.btnFaherenhit?.isSelected = false
        locaionPresenter.getLocationData(objLocation: self.objLocation!, strUnit: self.strUnit)
        locaionPresenter.getWeeklyForecastData(objLocation: self.objLocation!, strUnit: self.strUnit)

        
    }
    
    @IBAction func btnFahrenhitAction()
    {
        self.btnFaherenhit?.isSelected = true
        self.btnCelcisus?.isSelected = false
        self.strUnit  = "Imperial"
        UserDefaults.standard.set(self.strUnit, forKey: "Unit")
        UserDefaults.standard.synchronize()
        
        locaionPresenter.getLocationData(objLocation: self.objLocation!, strUnit: self.strUnit)
        locaionPresenter.getWeeklyForecastData(objLocation: self.objLocation!, strUnit: self.strUnit)


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
extension WeatherDetailVC : UICollectionViewDataSource
{
    
    /*func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
     
            return CGSize(width:80 , height:80)
        
    }*/

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.arrTitleImage?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        let dictTitle : NSMutableDictionary = self.arrTitleImage?.object(at: indexPath.row) as! NSMutableDictionary
        cell.lblTitle.text = dictTitle.value(forKey: "title") as? String
        let image : UIImage = UIImage(named:dictTitle.value(forKey: "image") as! String)!
        cell.imageView.image = image
        
        switch indexPath.row {
        case 0:
            cell.lblValue.text = self.objWeatherInfo?.strTemp
            break;
        case 1:
            cell.lblValue.text = self.objWeatherInfo?.strHumidiy
            break;
            
        case 2:
            cell.lblValue.text = self.objWeatherInfo?.strRain
            break;
            
        case 3:
            cell.lblValue.text = self.objWeatherInfo?.strWind
            break;
            
        default:
            break;
        }
        return cell
    }

    
}


extension WeatherDetailVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return self.arrWeeklyForCast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        
        let cell : WeeklyForecastCell = tableView.dequeueReusableCell(withIdentifier: "WeeklyForecastCell") as! WeeklyForecastCell
        
        
        let objWeatherInfo : WeatherInfo = self.arrWeeklyForCast[indexPath.row]
        
        print("cell for row weathe info",objWeatherInfo.strTempMin)

        cell.setupData(objWeatherInfo: objWeatherInfo)
        
        
        
        return cell
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
            }
}
