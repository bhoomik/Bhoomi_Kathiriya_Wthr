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
	

	
	
	
    func getLocationData(objLocation : Location,strUnit:String) {
        
        
            
        
        if(Helper.sharedInstance.checkIntenetConnection() == true)
        {
            
            self.locationView?.startLoading!()
            
            
            let strURL = String(format: "%@/weather?lat=%@&lon=%@&appid=%@&units=%@",kBaseURL,objLocation.strLatitude!,objLocation.strLongitude!,kAPIKey,strUnit)
            
            
            
           
            
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
                        strHumidity = String(format: "%@ %%",humidity)
                        print("humidity is",strHumidity)
                    }
                    if let temp = dictMain.value(forKey: "temp") as? NSNumber
                    {

                        print("temp1 is",temp)
                        if(strUnit == "Metric")
                        {
                        strTemp = String(format: "%@ C",temp)
                        }
                        else
                        {
                            strTemp = String(format: "%@ F",temp)

                        }
                            
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
                    
                    if(strUnit == "Metric")
                    {
                    strWind = String(format: "%@ at %@ km/h",strDegree,strSpeed)
                    }
                    else
                    {
                        strWind = String(format: "%@ at %@ mph",strDegree,strSpeed)

                    }
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
                
                var objWeatherInfo : WeatherInfo = WeatherInfo(strCity: strCity, strCountry: strCountry, dictWeather: dictWeather, strTemp: strTemp, strHumidiy: strHumidity, strRain: strRain, strWind: strWind, strDay: "", strTempMax: "", strTempMin: "")
                
                
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
	
	
	
    func getWeeklyForecastData(objLocation : Location,strUnit:String) {
        
        
        
        
        if(Helper.sharedInstance.checkIntenetConnection() == true)
        {
            
            self.locationView?.startLoading!()
            
            
      //      http://api.openweathermap.org/data/2.5/weather
            
         //   http://api.openweathermap.org/data/2.5/forecast/daily?lat=-33.863400&lon=151.211000&units=metric&APPID=c6e381d8c7ff98f0fee43775817cf6ad&cnt=7
            
            let strURL = String(format: "%@/forecast/daily?lat=%@&lon=%@&appid=%@&units=%@&cnt=7",kBaseURL,objLocation.strLatitude!,objLocation.strLongitude!,kAPIKey,strUnit)
            
            
            
            
            
            print("get weekly forecast method url",strURL)
            
            
            
            
            locationService.createRequest(qMes: "",  strURL: strURL, method: "GET", completionBlock: { (output)   in
                // your failure handle
                
                print("get weekly forecast output is",output)
                
                // let dictResponse = output
                
                var dictTemp : NSDictionary  = NSDictionary()
                
                dictTemp = output as NSDictionary
                
                
                print("weekly forecast dict is",dictTemp)
                
                
                var arrWeekly : NSArray = NSArray()
                
                var arrWeeklyForeCast  =  [WeatherInfo]()
                if let weather = dictTemp.value(forKey: "list") as? NSArray
                    
                {
                    
                    arrWeekly = weather
                    
                    print("arrweely is",arrWeekly)
                    
                }
                
                for (_, element) in (arrWeekly.enumerated())
                {
                    let dictWeather = element as! NSDictionary
                    
                    var strTimeInterVal : String = ""
                 
                    var strDay : String = ""
                    var strTempMin : String = ""
                    var strTempMax : String = ""
                    
                if let date = dictWeather.value(forKey: "dt") as? NSNumber
                {
                    
                    strTimeInterVal = String(format: "%@",date)
                  //  strCity = city
                   // print("city is",strCity)
                    
                    var timeInterval : TimeInterval?  = self.parseDuration(strTimeInterVal)
                    
                    let date = Date(timeIntervalSince1970: timeInterval!)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
                    dateFormatter.locale = NSLocale.current
                  //  dateFormatter.dateFormat = "yyyy-MM-dd" //Specify your format that you want
                    
                    dateFormatter.dateFormat = "MM-dd-yyyy" //Specify your format that you want

                    strDay = dateFormatter.string(from: date)
                    
                    print("strdate is",strDay)
                    print("date from interval is",date)

                }
                    
                    var  dictMain : NSDictionary  = NSDictionary()
                    
                    if let maindict = dictWeather.value(forKey: "temp") as? NSDictionary
                        
                    {
                        dictMain = maindict
                        
                        if let temp = dictMain.value(forKey: "max") as? NSNumber
                        {
                            
                            print("temp1 is",temp)
                            if(strUnit == "Metric")
                            {
                                strTempMax = String(format: "%@",temp)
                            }
                            else
                            {
                                strTempMax = String(format: "%@",temp)
                                
                            }
                            
                            print("temp is",strTempMax)
                        }
                        if let temp = dictMain.value(forKey: "min") as? NSNumber
                        {
                            
                            print("temp1 is",temp)
                            if(strUnit == "Metric")
                            {
                                strTempMin = String(format: "%@",temp)
                            }
                            else
                            {
                                strTempMin = String(format: "%@",temp)
                                
                            }
                            
                            print("temp is",strTempMax)
                        }
                    }
                    
                    var dictForecast : NSMutableDictionary = NSMutableDictionary()
                    dictForecast  = dictWeather.mutableCopy() as! NSMutableDictionary
                    
                    var objWeatherInfo : WeatherInfo = WeatherInfo(strCity: "", strCountry: "", dictWeather: dictForecast, strTemp: "", strHumidiy: "", strRain: "", strWind: "", strDay: strDay, strTempMax: strTempMax, strTempMin: strTempMin)
                    
                    arrWeeklyForeCast.append(objWeatherInfo)
                    
                }
                
                print("arrweeklyforecast is",arrWeeklyForeCast)
                
                self.locationView?.setWeeklyForecastData!(arrWeatherInfo: arrWeeklyForeCast)
              /*  var strTemp : String = ""
                var strRain : String = ""
                var strHumidity : String = ""
                var strWind : String = ""
                var strCity : String = ""
                var strCountry : String = ""
                
                
                
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
                        strHumidity = String(format: "%@ %%",humidity)
                        print("humidity is",strHumidity)
                    }
                    if let temp = dictMain.value(forKey: "temp") as? NSNumber
                    {
                        
                        print("temp1 is",temp)
                        if(strUnit == "Metric")
                        {
                            strTemp = String(format: "%@ C",temp)
                        }
                        else
                        {
                            strTemp = String(format: "%@ F",temp)
                            
                        }
                        
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
                    
                    if(strUnit == "Metric")
                    {
                        strWind = String(format: "%@ at %@ km/h",strDegree,strSpeed)
                    }
                    else
                    {
                        strWind = String(format: "%@ at %@ mph",strDegree,strSpeed)
                        
                    }
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
                
                */
                
                
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
    
	
	
	
	
	
	
    func parseDuration(_ timeString:String) -> TimeInterval {
        guard !timeString.isEmpty else {
            return 0
        }
        
        var interval:Double = 0
        
        let parts = timeString.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        
        return interval
    }
	
	
	
	
	
	
	
	
	
}
