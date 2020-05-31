//
//  profileApi.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class userProfileApi: NSObject {
    
    class func getPrifle(completion: @escaping(_ error: Error?,_ success: Bool,_ product: userProfile?)-> Void){
       
        guard let user_token = helperLogin.getAPIToken() else {
                   completion(nil, false,nil)
                   return
        }
         let url = URLs.main + "user" + "/\(user_token)"
        
        
        print(url)
        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error,false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let userProfiles = try JSONDecoder().decode(userProfile.self, from: response.data!)
                    if userProfiles.status == false {
                        completion(nil,true,userProfiles)
                    }else {
                        completion(nil,true,userProfiles)
                    }
                }catch{
                    print("error")
                    completion(nil,true,nil)
                }
            }
        }
    }
    
    class func upadateProfile(name: String, phone: String,email: String,address: String,password: String,old_password: String,  completion: @escaping(_ error: Error?,_ networkSuccess: Bool,_ upadteProfiles: Message?)-> Void){
       
        guard let user_token = helperLogin.getAPIToken() else {
                   completion(nil, false,nil)
                   return
        }
         let url = URLs.main + "editUser" + "/\(user_token)"
        
        let parametars = [
            "name": name,
            "email":email,
            "phone": phone,
            "address": address,
            "password": password,
            "old_password": old_password
        ]
        
       	
        print(url)
        print(parametars)
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let userProfiles = try JSONDecoder().decode(Message.self, from: response.data!)
                    if userProfiles.status == false {
                        completion(nil,true,userProfiles)
                    }else {
                        completion(nil,true,userProfiles)
                    }
                }catch{
                    print("error")
                    completion(nil,true,nil)
                }
            }
        }
    }
}
