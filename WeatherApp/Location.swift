//
//  City.swift
//  WeatherApp
//
//  Created by Bhoomi Kathiriya on 12/10/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import Foundation

class City: NSObject
{
    
    var strCityName: String?
    //   var strEventSubtitle: String?
    //  var strSubTaskDescription: String?
    var strCountryName : String?
    // var isTaskSelected = false
    var strEventId: String?
    var arrEventAssets : NSMutableArray?
    var arrEventUsers : NSMutableArray?
    var dictLocation : NSMutableDictionary?
    init(strCity: String, strCountry: String, dictLocation: NSMutableDictionary , eventId: String) {
        self.strCityName = strCity
        self.dictLocation = dictLocation
        self.strEventId = eventId
        self.strCountryName = strCountry
    }
    
}
