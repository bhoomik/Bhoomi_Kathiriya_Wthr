//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Bhoomi Kathiriya on 14/10/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import Foundation


@objc protocol WeatherInfo: NSObjectProtocol {
    
    @objc optional func startLoading()
    @objc optional func finishLoading()
    
    
    @objc optional func setEmptyNews()
    //@objc optional func setNewsData(news: [News])
    
    @objc optional func setWeatherInfo()
    
    
    //@objc optional func setImageDetail(image:UIImage)
    //@objc optional func setNewsDetail(news:News)
    
}
