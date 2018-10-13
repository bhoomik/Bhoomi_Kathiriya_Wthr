//
//  City.swift
//  WeatherApp
//
//  Created by Bhoomi Kathiriya on 12/10/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import Foundation

class Location: NSObject
{
    
    var strCityName: String?
    var strCountryName : String?
    var arrEventAssets : NSMutableArray?
    var arrEventUsers : NSMutableArray?
    var dictLocation : NSMutableDictionary?
    var strLatitude : String?
    var strLongitude : String?
    init(strCity: String, strCountry: String, dictLocation: NSMutableDictionary , strLatitude: String,strLongitude: String) {
        self.strCityName = strCity
        self.dictLocation = dictLocation
        self.strCountryName = strCountry
        self.strLongitude = strLongitude
        self.strLatitude = strLatitude
    }
    
}
