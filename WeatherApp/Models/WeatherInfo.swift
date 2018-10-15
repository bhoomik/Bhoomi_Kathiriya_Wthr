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
    var dictWeather : NSMutableDictionary?
    var strLatitude : String?
    var strLongitude : String?
    var strTemp : String?
    var strHumidiy : String?
    var strRain : String?
    var strWind : String?
    var strDay : String?
    var strTempMin : String?
    var strTempMax : String?

    
    init(strCity: String, strCountry: String, dictWeather: NSMutableDictionary , strTemp: String,strHumidiy: String,strRain : String,strWind : String,strDay : String,strTempMax : String,strTempMin: String) {
        self.strCityName = strCity
        self.dictWeather = dictWeather
        self.strCountryName = strCountry
        self.strRain = strRain
        self.strHumidiy = strHumidiy
        self.strTemp = strTemp
        self.strWind = strWind
        self.strTempMax = strTempMax
        self.strTempMin = strTempMin
        self.strDay = strDay
    }
    
}


