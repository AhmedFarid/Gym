//
//  helperLogin.swift
//  Gym
//
//  Created by Ahmed farid on 5/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import UIKit

class helperLogin: NSObject {
    
    class func restartApp(){
       guard let window = UIApplication.shared.keyWindow else {return}
            if getAPIToken() == nil {
                let navigationController = UINavigationController(rootViewController: langAndCountryVC())
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }else {
                let navigationController = UINavigationController(rootViewController: homeVC())
                window.rootViewController = navigationController
                window.makeKeyAndVisible()

            }
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        }
    
    class func dleteAPIToken() {
           let def = UserDefaults.standard
           def.removeObject(forKey: "user_token")
           def.synchronize()
           
           restartApp()
       }
    
    class func saveAPIToken(token: Int) {
        let def = UserDefaults.standard
        def.setValue(token, forKey: "user_token")
        def.synchronize()
        
        restartApp()
    }
    
    class func saveLangData(mainLangs: String, mianCountrys: String, mainCurancys: String) {
        let def = UserDefaults.standard
        def.setValue(mainLangs, forKey: "mainLangs")
        def.setValue(mianCountrys, forKey: "mianCountrys")
        def.setValue(mainCurancys, forKey: "mainCurancys")
        def.synchronize()
    }
    
    class func getLangData() -> (mainLangs: String?, mianCountrys: String?, mainCurancys: String?) {
           let def = UserDefaults.standard
           return (def.object(forKey: "mainLangs") as? String,def.object(forKey: "mianCountrys") as? String,def.object(forKey: "mainCurancys") as? String)
       }
    
    class func dleteLangData() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "mainLangs")
        def.removeObject(forKey: "mianCountrys")
        def.removeObject(forKey: "mainCurancys")
        def.synchronize()
        
        restartApp()
    }
    
    class func getAPIToken() -> Int? {
        let def = UserDefaults.standard
        return def.object(forKey: "user_token") as? Int
    }
}
