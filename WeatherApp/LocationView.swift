//
//  NewsView.swift
//  Swift_MVP
//
//
//  Copyright © 2017 balitax. All rights reserved.
//

import Foundation

@objc protocol LocationView: NSObjectProtocol {
	
    @objc optional func startLoading()
	@objc optional func finishLoading()

	
    @objc optional func setEmptyNews()
    //@objc optional func setNewsData(news: [News])
    
    @objc optional func setLocationData()

     //@objc optional func setImageDetail(image:UIImage)
    //@objc optional func setNewsDetail(news:News)
	
}
