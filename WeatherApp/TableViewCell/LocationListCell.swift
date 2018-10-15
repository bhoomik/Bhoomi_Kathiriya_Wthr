//
//  LocationListCell.swift
//  WeatherApp
//
//  Created by Bhoomi Kathiriya on 11/10/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class LocationListCell: UITableViewCell {

    
    @IBOutlet weak var lblLocation : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupData(objCity:Location)
    {
      
        let strLocation = String(format: "%@, %@",objCity.strCityName!,objCity.strCountryName!)

        self.lblLocation?.text = strLocation
       
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
