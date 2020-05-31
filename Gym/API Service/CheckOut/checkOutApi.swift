//
//  checkOutApi.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class checkOutApi: NSObject {
    
    class func getAllShippingCategories(completion: @escaping(_ error: Error?,_ success: Bool,_ product: shippingCategories?)-> Void){
        
        let url = URLs.main + "shippingCategories"
        
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
                    let prdouct = try JSONDecoder().decode(shippingCategories.self, from: response.data!)
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
    
    class func getAllShippingServices(shippingCategoriesId: Int,completion: @escaping(_ error: Error?,_ success: Bool,_ product: shippingServices?)-> Void){
        
        let url = URLs.main + "shippingServices" + "/\(shippingCategoriesId)"
        
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
                    let prdouct = try JSONDecoder().decode(shippingServices.self, from: response.data!)
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
    
    class func submitOrder(shippingId: Int,completion: @escaping(_ error: Error?,_ success: Bool,_ product: OrderMessage?)-> Void){
        let url = URLs.main + "\(helperLogin.getLangData().mianCountrys ?? "")" + "/submitOrder"
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        let parametars = [
            "shippingId": shippingId,
            "userId": user_token
            ] as [String : Any]
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let prdouct = try JSONDecoder().decode(OrderMessage.self, from: response.data!)
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
