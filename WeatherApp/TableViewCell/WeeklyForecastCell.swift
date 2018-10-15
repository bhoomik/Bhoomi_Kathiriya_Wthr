//
//  WeeklyForecastCell.swift
//  WeatherApp
//
//  Created by Bhoomi Kathiriya on 15/10/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class WeeklyForecastCell: UITableViewCell {

    @IBOutlet weak var lblDay : UILabel?
    @IBOutlet weak var lblTempMin : UILabel?
    @IBOutlet weak var lblTempMax : UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupData(objWeatherInfo:WeatherInfo)
    {
        
       // let strLocation = String(format: "%@, %@",objCity.strCityName!,objCity.strCountryName!)
        
        self.lblDay?.text = objWeatherInfo.strDay
        self.lblTempMax?.text = objWeatherInfo.strTempMax
        self.lblTempMin?.text = objWeatherInfo.strTempMin

        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
