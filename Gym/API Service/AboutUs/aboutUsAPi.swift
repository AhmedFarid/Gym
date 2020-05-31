//
//  aboutUsAPi.swift
//  Gym
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class aboutUsAPi: NSObject {
    
    
    class func getAbout(completion: @escaping(_ error: Error?,_ success: Bool,_ about: AboutUs?)-> Void){
        
        let url = URLs.main + "\(helperLogin.getLangData().mainLangs ?? "")" + "/about"
        
        print(url)
        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let prdouct = try JSONDecoder().decode(AboutUs.self, from: response.data!)
                    if prdouct.status == false {
                        completion(nil,true,prdouct)
                    }else {
                        completion(nil,true,prdouct)
                    }
                }catch{
                    print("error")
                }
            }
        }
        
    }
}
