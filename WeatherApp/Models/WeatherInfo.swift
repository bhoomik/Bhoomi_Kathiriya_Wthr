//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Bhoomi Kathiriya on 14/10/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import Foundation



class WeatherInfo: NSObject
{
    
    var strCityName: String?
    var strCountryName : String?
    var arrEventAssets : NSMutableArray?
    var arrEventUsers : NSMutableArray?
    var dictWeather : NSMutableDictionary?
    var strLatitude : String?
    var strLongitude : String?
    var strTemp : String?
    var strHumidiy : String?
    var strRain : String?
    var strWind : String?

    init(strCity: String, strCountry: String, dictWeather: NSMutableDictionary , strTemp: String,strHumidiy: String,strRain : String,strWind : String) {
        self.strCityName = strCity
        self.dictWeather = dictWeather
        self.strCountryName = strCountry
        self.strRain = strRain
        self.strHumidiy = strHumidiy
        self.strTemp = strTemp
        self.strWind = strWind
    }
    
}


