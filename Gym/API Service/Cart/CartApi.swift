//
//  CartApi.swift
//  Gym
//
//  Created by Ahmed farid on 5/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class cartApi: NSObject {
    
    class func addCarts(productId: String,quantity: String, completion: @escaping(_ error: Error?,_ success: Bool,_ message: Message?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "productId": productId,
            "quantity": quantity,
            "userId": user_token
            ] as [String : Any]
        
        
        
        
        let url = URLs.main + "addToCart"
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let message = try JSONDecoder().decode(Message.self, from: response.data!)
                    if message.status == false {
                        completion(nil,true,message)
                    }else {
                        completion(nil,true,message)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
    
    class func cartList(completion: @escaping(_ error: Error?,_ success: Bool,_ cart: Cart?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
                   completion(nil, false,nil)
                   return
        }
        
        let url = URLs.main + "\(helperLogin.getLangData().mainLangs ?? "")" + "/\(helperLogin.getLangData().mianCountrys ?? "")" + "/userCart/\(user_token)"
        
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
                    let prdouct = try JSONDecoder().decode(Cart.self, from: response.data!)
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
    
    class func optionCarts(productId: String,quantity: String, completion: @escaping(_ error: Error?,_ success: Bool,_ message: Message?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let url = URLs.main + "updateCart"
        
        let parametars = [
            "userId": user_token,
            "productId": productId,
            "quantity": quantity
            ] as [String : Any]
       
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let message = try JSONDecoder().decode(Message.self, from: response.data!)
                    if message.status == false {
                        completion(nil,true,message)
                    }else {
                        completion(nil,true,message)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
    
    class func removerCart(productId: String, completion: @escaping(_ error: Error?,_ success: Bool,_ message: Message?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let url = URLs.main + "removeFromCart"
        
        let parametars = [
            "userId": user_token,
            "productId": productId
            ] as [String : Any]
       
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let message = try JSONDecoder().decode(Message.self, from: response.data!)
                    if message.status == false {
                        completion(nil,true,message)
                    }else {
                        completion(nil,true,message)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
    
}
