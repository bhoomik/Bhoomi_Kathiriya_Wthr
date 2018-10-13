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
                
                print("get news output is",output)
                
                // let dictResponse = output
                
                var dictTemp : NSDictionary  = NSDictionary()
                
                dictTemp = output as NSDictionary
                
                
                
                print("dict get news output",dictTemp)
                
                
                
                  var arrTemp : NSMutableArray?  = NSMutableArray()
                
                //  arrTemp    = dictTemp.value(forKey: "articles") as? NSMutableArray
                
                
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
