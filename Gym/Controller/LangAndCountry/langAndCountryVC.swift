//
//  langAndCountryVC.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import MOLH

class langAndCountryVC: UIViewController {
    
    @IBOutlet weak var engMark: UIImageView!
    @IBOutlet weak var arMark: UIImageView!
    @IBOutlet weak var saudiMark: UIImageView!
    @IBOutlet weak var emaratMark: UIImageView!
    @IBOutlet weak var kuwaitMark: UIImageView!
    @IBOutlet weak var egyBTNMark: UIImageView!
    
    var mainLang = ""
    var mianCountry = ""
    var mainCurancy = ""
    var fromMenu = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(true)
        
        if fromMenu == true {
            if helperLogin.getLangData().mainLangs == "ar"{
                engMark.isHidden = true
                arMark.isHidden = false
                mainLang = "ar"
                if helperLogin.getLangData().mianCountrys == "EGP" {
                    saudiMark.isHidden = true
                    emaratMark.isHidden = true
                    kuwaitMark.isHidden = true
                    egyBTNMark.isHidden = false
                    mianCountry = "EGP"
                    mainCurancy = "جنيه"
                }else if helperLogin.getLangData().mianCountrys == "KWD" {
                    saudiMark.isHidden = true
                    emaratMark.isHidden = true
                    kuwaitMark.isHidden = false
                    egyBTNMark.isHidden = true
                    mianCountry = "KWD"
                    mainCurancy = "دينار"
                }else if helperLogin.getLangData().mianCountrys == "AED" {
                    saudiMark.isHidden = true
                    emaratMark.isHidden = false
                    kuwaitMark.isHidden = true
                    egyBTNMark.isHidden = true
                    mainCurancy = "درهم"
                    mianCountry = "AED"
                }else if helperLogin.getLangData().mianCountrys == "SAR"{
                    saudiMark.isHidden = false
                    emaratMark.isHidden = true
                    kuwaitMark.isHidden = true
                    egyBTNMark.isHidden = true
                    mainCurancy = "ريال"
                    mianCountry = "SAR"
                }
            }else if helperLogin.getLangData().mainLangs == "en" {
                engMark.isHidden = false
                arMark.isHidden = true
                mainLang = "en"
                if helperLogin.getLangData().mianCountrys == "EGP" {
                    saudiMark.isHidden = true
                    emaratMark.isHidden = true
                    kuwaitMark.isHidden = true
                    egyBTNMark.isHidden = false
                    mianCountry = "EGP"
                    mainCurancy = "EGP"
                }else if helperLogin.getLangData().mianCountrys == "KWD" {
                    saudiMark.isHidden = true
                    emaratMark.isHidden = true
                    kuwaitMark.isHidden = false
                    egyBTNMark.isHidden = true
                    mianCountry = "KWD"
                    mainCurancy = "KWD"
                }else if helperLogin.getLangData().mianCountrys == "AED" {
                    saudiMark.isHidden = true
                    emaratMark.isHidden = false
                    kuwaitMark.isHidden = true
                    egyBTNMark.isHidden = true
                    mianCountry = "AED"
                    mainCurancy = "AED"
                }else if helperLogin.getLangData().mianCountrys == "SAR"{
                    saudiMark.isHidden = false
                    emaratMark.isHidden = true
                    kuwaitMark.isHidden = true
                    egyBTNMark.isHidden = true
                    mianCountry = "SAR"
                    mainCurancy = "SAR"
                }
            }
        }
        
    }
    
    
    @IBAction func engBTN(_ sender: Any) {
        engMark.isHidden = false
        arMark.isHidden = true
        mainLang = "en"
    }
    
    @IBAction func arBTN(_ sender: Any) {
        engMark.isHidden = true
        arMark.isHidden = false
        mainLang = "ar"
    }
    
    @IBAction func saudiBTN(_ sender: Any) {
        saudiMark.isHidden = false
        emaratMark.isHidden = true
        kuwaitMark.isHidden = true
        egyBTNMark.isHidden = true
        mianCountry = "SAR"
        mainCurancy = "SAR"
        
    }
    
    @IBAction func emaratBTN(_ sender: Any) {
        saudiMark.isHidden = true
        emaratMark.isHidden = false
        kuwaitMark.isHidden = true
        egyBTNMark.isHidden = true
        mianCountry = "AED"
        mainCurancy = "AED"
    }
    
    @IBAction func kuwaitBTN(_ sender: Any) {
        saudiMark.isHidden = true
        emaratMark.isHidden = true
        kuwaitMark.isHidden = false
        egyBTNMark.isHidden = true
        mianCountry = "KWD"
        mainCurancy = "KWD"
    }
    @IBAction func egyBTN(_ sender: Any) {
        saudiMark.isHidden = true
        emaratMark.isHidden = true
        kuwaitMark.isHidden = true
        egyBTNMark.isHidden = false
        mianCountry = "EGP"
        mainCurancy = "EGP"
        
    }
    
    @IBAction func nextBTN(_ sender: Any) {
        
        guard mainLang != "" else {
            self.showAlert(title: "", message: "Please choose language")
            return
        }
        
        guard mianCountry != "" else {
            self.showAlert(title: "", message: "Please choose country")
            return
        }
        
        if mainLang == "ar" {
            if mianCountry == "EGP" {
                mainCurancy = "جنيه"
            }else if mianCountry == "KWD" {
                mainCurancy = "دينار"
            }else if mianCountry == "AED" {
                mainCurancy = "درهم"
            }else if mianCountry == "SAR"{
                mainCurancy = "ريال"
            }
            
        }else if mainLang == "en"{
            if mianCountry == "EGP" {
                mainCurancy = "EGP"
            }else if mianCountry == "KWD" {
                mainCurancy = "KWD"
            }else if mianCountry == "AED" {
                mainCurancy = "AED"
            }else if mianCountry == "SAR"{
                mainCurancy = "SAR"
            }
        }
        helperLogin.saveLangData(mainLangs: mainLang, mianCountrys: mianCountry, mainCurancys: mainCurancy)
        if fromMenu == false {
            let vc = loginVC(nibName: "loginVC", bundle: nil)
            self.navigationController!.pushViewController(vc, animated: true)
            MOLH.setLanguageTo(mainLang)
            MOLH.reset(transition: .transitionCrossDissolve, duration: 0.25)
        }else {
            let vc = homeVC(nibName: "homeVC", bundle: nil)
            self.navigationController!.pushViewController(vc, animated: true)
            MOLH.setLanguageTo(mainLang)
            MOLH.reset(transition: .transitionCrossDissolve, duration: 0.25)
        }
    }
    
}
