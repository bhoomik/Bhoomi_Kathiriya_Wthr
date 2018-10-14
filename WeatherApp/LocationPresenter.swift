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
            
          //  self.newsView?.startLoading()
            
            
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
                
                if(arrTemp == nil || arrTemp?.count == 0)
                {
                   // self.newsView?.setEmptyNews()
                    //print set empty news
                }
                else
                {
                   /* var arrNews = [News]()
                    
                    for (index, element) in (arrTemp?.enumerated())!
                    {
                        let dictNews = element as! NSDictionary
                        
                        let dictSource : NSDictionary = dictNews.value(forKey: "source") as! NSDictionary
                        //   let strFullName : String = String(format: "%@ %@",dictAssignee.value(forKey: "firstName") as! String,dictAssignee.value(forKey: "lastName") as! String)
                        //                    News(newsTitle : dictNews.value(forKey: "title") as! String, strDescription: dictNews.value(forKey: "description") as! String, strAuthor: dictNews.value(forKey: "author") as! String, strPublishedat: dictNews.value(forKey: "publishedAt") as! String, strImageURL: dictNews.value(forKey: "urlToImage") as! String, strNewsURL: dictNews.value(forKey: "url") as! String, dictNews:dictNews.mutableCopy() as! NSMutableDictionary, newsId: dictSource.value(forKey: "id") as! String )
                        
                        print("dictNews is",dictNews)
                        
                        var strTitle : String  =  ""
                         if let value = (dictNews.value(forKey: "title") as? String)
                            
                        {
                            strTitle = dictNews.value(forKey: "title") as! String
                            
                        }
                        
                        var strDescription : String  =  ""
                        if let value = (dictNews.value(forKey: "description") as? String)
                            
                        {
                            strDescription = dictNews.value(forKey: "description") as! String
                            
                        }
                        var strAuthor : String  =  ""
                        
                        if let value = (dictNews.value(forKey: "author") as? String)
                            
                        {
                            strAuthor = dictNews.value(forKey: "author") as! String
                            
                        }
                        
                        var strPublishedAt : String  =  ""
                        
                        if let value = (dictNews.value(forKey: "publishedAt") as? String)
                            
                        {
                            strPublishedAt = dictNews.value(forKey: "publishedAt") as! String
                            
                        }
                        
                        var strImageURL : String  =  ""
                        
                        if let value = (dictNews.value(forKey: "urlToImage") as? String)
                            
                        {
                            strImageURL = dictNews.value(forKey: "urlToImage") as! String
                            
                        }
                        var strNewsURL : String  =  ""
                        
                        if let value = (dictNews.value(forKey: "url") as? String)
                            
                        {
                            strNewsURL = dictNews.value(forKey: "url") as! String
                            
                        }
                        
                        var ObjNews : News =      News(newsTitle : strTitle, strDescription: strDescription, strAuthor:strAuthor , strPublishedat: strPublishedAt, strImageURL: strImageURL, strNewsURL: strNewsURL, dictNews:dictNews.mutableCopy() as! NSMutableDictionary, newsId: dictSource.value(forKey: "id") as! String )
                        
                        
                        arrNews.append(ObjNews)
                        
                    }*/
                    
                   // print("arr News is",arrNews)
                    
                    //print("arr News count is",arrNews.count)
                    //self.newsView?.setNewsData(news: arrNews)
                }
                // print("arr all assets",arrTemp?.count)
                
                
           
                
                  DispatchQueue.main.async { () -> Void in
                    
                    //self.newsView?.finishLoading()
                    /*  if(arrTemp?.count == 0)
                     {
                     self.lblNoAssignee?.isHidden = false
                     }
                     else
                     {
                     self.lblNoAssignee?.isHidden = true
                     }
                     self.tblAddMechanics?.reloadData()*/
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
                //    self.newsView?.finishLoading()
                    /*   self.lblNoAssignee?.isHidden = false
                     
                     self.tblAddMechanics?.reloadData()*/
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
