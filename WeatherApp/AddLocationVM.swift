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

    func attachView(view: LocationView) {
        locationView = view
    }

    func InsertData(objLocation : Location)
    {
        
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let context = appDelegate?.persistentContainer.viewContext
        
        let strLocationId = String(format: "%@,%@",objLocation.strLatitude!,objLocation.strLongitude!)

        if(self.someEntityExists(id: strLocationId)==true)
        {
            
            print("location alreay added")
            return;
            
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "LocationInfo", in: context!)
        let newLocation = NSManagedObject(entity: entity!, insertInto: context)

        
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
    
    func someEntityExists(id: String) -> Bool {
        var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LocationInfo")
        fetchRequest.predicate = NSPredicate(format: "locationid = %@", id)
        
        var results: [NSManagedObject] = []
        
        do {
            let managedObjectContext = appDelegate?.persistentContainer.viewContext

            results = (try managedObjectContext?.fetch(fetchRequest))!
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
    }
    
    func retrieveData()
    {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate

        let context = appDelegate?.persistentContainer.viewContext
        
     //   let entity = NSEntityDescription.entity(forEntityName: "LocationInfo", in: context!)
     //   let newLocation = NSManagedObject(entity: entity!, insertInto: context)
        
        

        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationInfo")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context?.fetch(request)
            
            var arrLocationTemp  = [Location]()

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
                arrLocationTemp.append(objCity)
                //self.appDelegate!.arrCityList.append(objCity)

                print("arr location temp",arrLocationTemp)
                print("locationview",locationView)
                
                print(data.value(forKey: "city") as! String)
            }
            self.locationView?.setLocationData!(location:arrLocationTemp)

            
        } catch {
            
            print("Failed")
        }
        
        
    }


}
