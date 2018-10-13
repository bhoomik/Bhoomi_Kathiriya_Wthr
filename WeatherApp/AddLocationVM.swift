//
//  AddLocationVM.swift
//  WeatherApp
//
//  Created by Bhoomi Kathiriya on 13/10/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class AddLocationVM
{

    static let sharedInstance =  AddLocationVM()
    var appDelegate : AppDelegate?

    weak private var locationView: LocationView?

    func InsertData(objLocation : Location)
    {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate?.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "LocationInfo", in: context!)
        let newLocation = NSManagedObject(entity: entity!, insertInto: context)
        var strLocationId = String(format: "%@,%@",objLocation.strLatitude!,objLocation.strLongitude!)

        
        newLocation.setValue(objLocation.strCityName, forKey: "city")
        newLocation.setValue(objLocation.strCountryName, forKey: "country")
        newLocation.setValue(objLocation.strLatitude, forKey: "latitude")
        newLocation.setValue(objLocation.strLongitude, forKey: "longitude")
        newLocation.setValue(strLocationId, forKey: "locationid")

        
        do {
            
            try context?.save()
            
        } catch {
            
            print("Failed saving")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationInfo")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context?.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "city") as! String)
            }
            
        } catch {
            
            print("Failed")
        }

        
    }
    
    func retrieveData()
    {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate?.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "LocationInfo", in: context!)
     //   let newLocation = NSManagedObject(entity: entity!, insertInto: context)
        
        

        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationInfo")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context?.fetch(request)
            for data in result as! [NSManagedObject]
            {
                let strCity = data.value(forKey: "city") as! String
                let strCountry = data.value(forKey: "country") as! String
                let strLatitude = data.value(forKey: "latitude") as! String
                let strLongitude = data.value(forKey: "longitude") as! String

                let strLocationId = String(format: "%@,%@",strLatitude,strLongitude)

                let dictLocation : NSMutableDictionary = NSMutableDictionary()
                dictLocation.setValue(strCity, forKey: "city")
                dictLocation.setValue(strCountry, forKey: "country")
                
                dictLocation.setValue(strLatitude, forKey: "latitude")
                dictLocation.setValue(strLongitude, forKey: "longitude")

                let objCity : Location = Location(strCity: strCity, strCountry:strCountry, dictLocation: dictLocation, strLatitude: strLatitude, strLongitude: strLongitude, strLocationId: strLocationId)
                self.appDelegate!.arrCityList.append(objCity)

                self.locationView?.setLocationData!()
                
                print(data.value(forKey: "city") as! String)
            }
            
        } catch {
            
            print("Failed")
        }
        
        
    }


}
