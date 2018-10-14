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
}

class WeatherDetailVC: UIViewController {

    let reuseIdentifier = "collectionViewCellId"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var objLocation : Location?
    
    private let locaionPresenter = LocationPresenter(locationService: LocationService())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
        // Do any additional setup after loading the view.
    }

    func commonInit()
    {
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.imageView.backgroundColor = UIColor.gray
        
        return cell
    }

    
}