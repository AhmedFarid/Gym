//
//  userOrderApi.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class userOrderApi: NSObject {
    
    class func getAllUserOrder(completion: @escaping(_ error: Error?,_ success: Bool,_ product: UserOrders?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let url = URLs.main + "userOrders" + "/\(user_token)"
        
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
                    let prdouct = try JSONDecoder().decode(UserOrders.self, from: response.data!)
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
    
    class func getAllUserOrderDiteals(orderId: Int,completion: @escaping(_ error: Error?,_ success: Bool,_ product: UserOrdersDetiles?)-> Void){
        
        let url = URLs.main + "\(helperLogin.getLangData().mainLangs ?? "")" + "/order" + "/\(orderId)"
        
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
                    let prdouct = try JSONDecoder().decode(UserOrdersDetiles.self, from: response.data!)
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
