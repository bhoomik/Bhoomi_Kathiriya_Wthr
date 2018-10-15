//
//  NewsPresenter.swift
//  Swift_MVP
//
//

import Foundation

class LocationPresenter {
	
	private let locationService: LocationService
	weak private var locationView: LocationView?
	
   init(locationService : LocationService) {
		self.locationService = locationService
	}
	
	func attachView(view: LocationView) {
		locationView = view
	}
	
	func detachView() {
		locationView = nil
	}
	

	
	
	
    func getLocationData(objLocation : Location) {
        
        
            
        
        if(Helper.sharedInstance.checkIntenetConnection() == true)
        {
            
            self.locationView?.startLoading!()
            
            
            let strURL = String(format: "%@?lat=%@&lon=%@&appid=%@&units=metric",kBaseURL,objLocation.strLatitude!,objLocation.strLongitude!,kAPIKey)
            
            
            
           
            
            print("get news method url",strURL)
            
            
            
            
            locationService.createRequest(qMes: "",  strURL: strURL, method: "GET", completionBlock: { (output)   in
                // your failure handle
                
                print("get weather output is",output)
                
                // let dictResponse = output
                
                var dictTemp : NSDictionary  = NSDictionary()
                
                dictTemp = output as NSDictionary
                
                
                var strTemp : String = ""
                var strRain : String = ""
                var strHumidity : String = ""
                var strWind : String = ""
                var strCity : String = ""
                var strCountry : String = ""

             //   if let firstName = dictAssignee.value(forKey: "firstName") as? String

                
                if let city = dictTemp.value(forKey: "name") as? String
                {
                    strCity = city
                    print("city is",strCity)
                }
                
                var  dictMain : NSDictionary  = NSDictionary()
                
                if let maindict = dictTemp.value(forKey: "main") as? NSDictionary

                {
                    dictMain = maindict
                    
                    if let humidity = dictMain.value(forKey: "humidity") as? NSNumber
                    {
                        strHumidity = String(format: "%@",humidity)
                        print("humidity is",strHumidity)
                    }
                    if let temp = dictMain.value(forKey: "temp") as? NSNumber
                    {

                        print("temp1 is",temp)
                        strTemp = String(format: "%@",temp)
                        print("temp is",strTemp)
                    }

                    
                    print("main dict is",dictMain)
                }
                
                if let sysict = dictTemp.value(forKey: "sys") as? NSDictionary
                    
                {
                  //  dictMain = maindict
                    
                    if let country = sysict.value(forKey: "country") as? String
                    {
                        strCountry = String(format: "%@",country)
                        print("country is",strCountry)
                    }
                    
                }
                
                var  dictWind : NSDictionary  = NSDictionary()
                
                if let winddict = dictTemp.value(forKey: "wind") as? NSDictionary
                    
                {
                    dictWind = winddict
                    var strSpeed : String = ""
                    var strDegree : String = ""
                    if let speed = dictWind.value(forKey: "speed") as? NSNumber
                    {
                        strSpeed = String(format: "%@",speed)
                        print("humidity is",strHumidity)
                    }
                    if let degree = dictWind.value(forKey: "deg") as? NSNumber
                    {
                        strDegree = String(format: "%@",degree)
                        print("temp is",strTemp)
                    }
                    
                    strWind = String(format: "%@ at %@",strDegree,strSpeed)
                    print("wind info",strWind)
                }
                
                var  dictRain : NSDictionary  = NSDictionary()
                var arrWeather : NSArray = NSArray()
                
                if let weather = dictTemp.value(forKey: "weather") as? NSArray
                    
                {
                    
                    arrWeather = weather
                    
                    print("arrweather is",arrWeather)
                    
                    if let rainDict = arrWeather.object(at: 0) as? NSDictionary
                    {
                        dictRain =  rainDict
                        
                        if let rain = dictRain.value(forKey: "main") as? String
                        {
                            strRain = String(format: "%@",rain)
                            print("temp is",strRain)
                        }
                        
                    }
                }
                var dictWeather : NSMutableDictionary = NSMutableDictionary()
                dictWeather  = dictTemp.mutableCopy() as! NSMutableDictionary
                
                var objWeatherInfo : WeatherInfo = WeatherInfo(strCity: strCity, strCountry: strCountry, dictWeather: dictWeather, strTemp: strTemp, strHumidiy: strHumidity, strRain: strRain, strWind: strWind)
                
                
                print("dict weather output",dictTemp)
                
                
                
                  var arrTemp : NSMutableArray?  = NSMutableArray()
                
                //  arrTemp    = dictTemp.value(forKey: "articles") as? NSMutableArray
                
                self.locationView?.setWeatherInfo!(objWeatherInfo: objWeatherInfo)

                
                print("arrtemp count",arrTemp?.count)
                
                
           
                
                  DispatchQueue.main.async { () -> Void in
                    
                    self.locationView?.finishLoading!()
                  }
                
            }, andFailureBlock:   { (failure) -> Void in
                
//                if let httpResponse = failure as? HTTPURLResponse
//                {
//                    if (httpResponse.statusCode == 401)
//                    {
//
//                    }
//
//                }
                DispatchQueue.main.async { () -> Void in
                    self.locationView?.finishLoading!()

                }
            })
            
            
        }
        else
        {
            
          //  self.displayNoInternetAlert()
            //return
            
        }
        
      
        
    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
