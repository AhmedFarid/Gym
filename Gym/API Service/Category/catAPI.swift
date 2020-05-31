//
//  catAPI.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class catAPI: NSObject {
    
    class func getAllCat(completion: @escaping(_ error: Error?,_ success: Bool,_ product: Category?)-> Void){
        
        let url = URLs.main + "\(helperLogin.getLangData().mainLangs ?? "")" + "/\(helperLogin.getLangData().mianCountrys ?? "")" + "/allCategories"
        
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
                    let prdouct = try JSONDecoder().decode(Category.self, from: response.data!)
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
