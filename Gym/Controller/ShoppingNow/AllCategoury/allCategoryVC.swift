//
//  allCategoryVC.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class allCategoryVC: UIViewController, NVActivityIndicatorViewable{

    @IBOutlet weak var catCollectionVIew: UICollectionView!
    
    
    var cat = [categoryData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNav(logo: true, menu: true, cart: true, back: false)
        setUpNavColore(false)
        // Do any additional setup after loading the view.
        
        catCollectionVIew.delegate = self
        catCollectionVIew.dataSource = self
        
        self.catCollectionVIew.register(UINib.init(nibName: "allCatCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        allProductHandelRefresh()
    }


    func allProductHandelRefresh(){
            let Loading = NSLocalizedString("Loading...", comment: "")
            startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
            catAPI.getAllCat{ (error,success,cat) in
                if let cat = cat{
                    self.cat = cat.data ?? []
                    self.catCollectionVIew.reloadData()
                    self.stopAnimating()
                }
                self.stopAnimating()
            }
        }
      
    }

extension allCategoryVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = allProductVC(nibName: "allProductVC", bundle: nil)
        vc.urlName = "/category/\(cat[indexPath.row].id ?? 0)"
        self.navigationController!.pushViewController(vc, animated: true)
        vc.singleItem = cat[indexPath.row]
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cat.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = catCollectionVIew.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? allCatCell {
            cell.configureCell(cat: cat[indexPath.row])
            
            return cell
        }else {
            return allCatCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let screenWidth = catCollectionVIew.frame.width
        
        var width = (screenWidth - 10)/2
        
        width = width < 130 ? 160 : width
        
        return CGSize.init(width: width, height: 200)
    }
}



