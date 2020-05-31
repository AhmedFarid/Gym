//
//  sideMnueVC.swift
//  Gym
//
//  Created by Ahmed farid on 5/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import SideMenu

class sideMnueVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavColore(true)
       
    }
    
    @IBAction func profileTN(_ sender: Any) {
        let vc = profileVC(nibName: "profileVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func homeBTN(_ sender: Any) {
        let vc = homeVC(nibName: "homeVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func myOrder(_ sender: Any) {
        let vc = userOrderVC(nibName: "userOrderVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shopNowBTN(_ sender: Any) {
        
        let vc = allCategoryVC(nibName: "allCategoryVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Bloges(_ sender: Any) {
        
        let vc = allBlogsVC(nibName: "allBlogsVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func aboutUsBTN(_ sender: Any) {
        let vc = aboutUsVC(nibName: "aboutUsVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func contactUsBTN(_ sender: Any) {
        let vc = contactVC(nibName: "contactVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func logoutBTN(_ sender: Any) {
        helperLogin.dleteAPIToken()
    }
    
    @IBAction func favBTN(_ sender: Any) {
        let vc = allProductVC(nibName: "allProductVC", bundle: nil)
        vc.urlName = "/userFavorite/\(helperLogin.getAPIToken() ?? 0)"
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cartBTN(_ sender: Any) {
        let vc = cartVC(nibName: "cartVC", bundle: nil)
        vc.fromMnue = true
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func allProductBTn(_ sender: Any) {
        let vc = allProductVC(nibName: "allProductVC", bundle: nil)
        vc.urlName = "/allProducts"
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newOffer(_ sender: Any) {
        let vc = allProductVC(nibName: "allProductVC", bundle: nil)
        vc.urlName = "/offers"
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func langAndCountryBTN(_ sender: Any) {
        let vc = langAndCountryVC(nibName: "langAndCountryVC", bundle: nil)
        vc.fromMenu = true
        self.navigationController!.pushViewController(vc, animated: true)
        //dismiss(animated: true, completion: nil)
    }
}
