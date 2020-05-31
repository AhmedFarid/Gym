//
//  authApi.swift
//  Gym
//
//  Created by Ahmed farid on 5/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Alamofire


class auhtApi: NSObject {
    
    class func login(email: String,password: String, completion: @escaping(_ error: Error?,_ success: Bool, _ userData: Auth?)-> Void){
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        let url = URLs.login
        
        print(url)
        print(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let login = try JSONDecoder().decode(Auth.self, from: response.data!)
                    if login.status == false {
                        completion(nil,true,login)
                    }else {
                        helperLogin.saveAPIToken(token: login.data?.id ?? 0)
                        completion(nil,true,login)
                    }
                }catch{
                    print("error")
                }
            }
        }
        
    }
    
    class func register(name: String, phone: String,email: String,password: String,address: String,confirm_password: String, completion: @escaping(_ error: Error?,_ success: Bool, _ userData: Auth?)-> Void){
        
        let parameters = [
            "name": name,
            "phone": phone,
            "email": email,
            "address": address,
            "password": password,
            "confirm_password": confirm_password
        ]
        
        let url = URLs.register
        
        print(url)
        print(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let register = try JSONDecoder().decode(Auth.self, from: response.data!)
                    if register.status == false {
                        completion(nil,true,register)
                    }else {
                        helperLogin.saveAPIToken(token: register.data?.id ?? 0)
                        completion(nil,true,register)
                    }
                }catch{
                    print("error")
                }
            }
        }
        
    }
    
}
