//
//  allProductVC.swift
//  Gym
//
//  Created by Ahmed farid on 5/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class allProductVC: UIViewController, NVActivityIndicatorViewable{
    
    @IBOutlet weak var allProductCollectionView: UICollectionView!
    
    
    var featuredData = [productData]()
    var singleItem: categoryData?
    var urlName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNav(logo: true, menu: true, cart: true, back: false)
        setUpNavColore(false)
        
        allProductCollectionView.delegate = self
        allProductCollectionView.dataSource = self
        
        self.allProductCollectionView.register(UINib.init(nibName: "productsCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        allProductHandelRefresh()
        
    }
    
    func allProductHandelRefresh(){
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        homeApi.product(url: urlName){ (error,success,featuredData) in
            if let featuredData = featuredData{
                self.featuredData = featuredData.data ?? []
                print(featuredData)
                self.allProductCollectionView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
  
}



extension allProductVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = productDetielsVC(nibName: "productDetielsVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        vc.SingleproductData = featuredData[indexPath.row]
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return featuredData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = allProductCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? productsCell {
            cell.configureCell(product:  featuredData[indexPath.row])
            
            return cell
        }else {
            return productsCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let screenWidth = allProductCollectionView.frame.width
        
        var width = (screenWidth - 10)/2
        
        width = width < 130 ? 160 : width
        
        return CGSize.init(width: width, height: 200)
    }
}


