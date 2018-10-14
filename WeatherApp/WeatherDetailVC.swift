//
//  WeatherDetailVC.swift
//  WeatherApp
//
//  Created by Bhoomi Kathiriya on 13/10/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class CollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!


}

class WeatherDetailVC: UIViewController {

    let reuseIdentifier = "collectionViewCellId"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrTitleImage : NSMutableArray? = NSMutableArray()
    var objLocation : Location?
    
    private let locaionPresenter = LocationPresenter(locationService: LocationService())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
        // Do any additional setup after loading the view.
    }

    func commonInit()
    {
        let dictTemp : NSMutableDictionary = NSMutableDictionary()
        dictTemp.setValue("Temperature", forKey: "title")
        dictTemp.setValue("temp.png", forKey: "image")

        self.arrTitleImage?.add(dictTemp)
        
        let dictHumidity : NSMutableDictionary = NSMutableDictionary()
        dictHumidity.setValue("Humidity", forKey: "title")
        dictHumidity.setValue("humidity", forKey: "image")

        self.arrTitleImage?.add(dictHumidity)
        
        
        let dictRainC : NSMutableDictionary = NSMutableDictionary()
        dictRainC.setValue("Rain", forKey: "title")
        dictRainC.setValue("rain", forKey: "image")

        self.arrTitleImage?.add(dictRainC)
        
        let dictWind : NSMutableDictionary = NSMutableDictionary()
        dictWind.setValue("Wind", forKey: "title")
        dictWind.setValue("wind", forKey: "image")

        self.arrTitleImage?.add(dictWind)
        
        self.collectionView.reloadData()

        
        locaionPresenter.getLocationData(objLocation: self.objLocation!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: IBAction Methods
    
    @IBAction func btnBackAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension WeatherDetailVC : UICollectionViewDataSource
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.arrTitleImage?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        let dictTitle : NSMutableDictionary = self.arrTitleImage?.object(at: indexPath.row) as! NSMutableDictionary
        cell.lblTitle.text = dictTitle.value(forKey: "title") as? String
        let image : UIImage = UIImage(named:dictTitle.value(forKey: "image") as! String)!
        cell.imageView.image = image
        
        return cell
    }

    
}
