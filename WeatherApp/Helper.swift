//
//  Helper.swift
//  Collecting_Arts
//
//  Created by Bhumi kathiria on 14/06/18.
//  Copyright © 2018 Bhumi kathiria. All rights reserved.
//

import Foundation
import  UIKit
typealias AlertCallback = (Bool?) -> ()

public class Helper
{
    static let sharedInstance = Helper()
    var appDelegate : AppDelegate?
    
    
    func checkIntenetConnection() -> Bool
    {
        if Reachability.isConnectedToNetwork()
        {
            print("Internet Connection Available!")
            return true
        }
        else
        {
            print("Internet Connection not Available!")
            return false
            
        }
        
    }
    
    func  logoutUser()
    {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        
        
        
        if (UIApplication.shared.keyWindow?.rootViewController as? UINavigationController) != nil
        {
            let nav = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
            
            nav.popToRootViewController(animated: true)
            
            print("app del nav",nav.viewControllers)
            
            
        }
        else
        {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "Login")
            
            let navigationController = UINavigationController(rootViewController: controller)
            
            navigationController.navigationBar.isHidden = true
            
            UIApplication.shared.keyWindow?.rootViewController  = navigationController
            
            
        }
        
        let defaults = UserDefaults.standard
        var userCredDict : NSMutableDictionary =  NSMutableDictionary()
        userCredDict =  UserDefaults.standard.object(forKey: "UserCred") as! NSMutableDictionary
        
        let strKey : String? = userCredDict.value(forKey: "Email") as? String
        
        defaults.removeObject(forKey: "UserCred")
        defaults.removeObject(forKey: "UserToken")
        defaults.removeObject(forKey: strKey!)
        defaults.removeObject(forKey: "MyTaskSearchText")
        
        defaults.synchronize()
        
        
    }
    func showAlert(title:String="", message:String, callback:@escaping AlertCallback) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
            callback(true)
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async { () -> Void in
            UIApplication.topViewController()?.present(alertController, animated: true, completion: {
                
            })
        }
    }
    
    func showDecisionAlertWithMessage(title:String="", message:String, callback:@escaping AlertCallback) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .cancel) { action -> Void in
            callback(true)
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "No", style: .default) { action -> Void in
            callback(false)
        }
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async { () -> Void in
            UIApplication.topViewController()?.present(alertController, animated: true, completion: {
                
            })
        }
    }
    
    
    

}
extension UIApplication {
    
    public class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
