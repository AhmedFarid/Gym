//
//  homeApi.swift
//  Gym
//
//  Created by Ahmed farid on 5/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class homeApi: NSObject {
    
    
    class func sliderApi(completion: @escaping(_ error: Error?,_ success: Bool,_ photos: Slider?)-> Void){
        
        let url = URLs.main + "\(helperLogin.getLangData().mainLangs ?? "")" + "/slider"
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
                    let images = try JSONDecoder().decode(Slider.self, from: response.data!)
                    if images.status == false {
                        completion(nil,true,images)
                    }else {
                        completion(nil,true,images)
                    }
                }catch{
                    print("error")
                }
            }
        }
        
    }
    
    class func bannerApi(completion: @escaping(_ error: Error?,_ success: Bool,_ photos: banner?)-> Void){
        
        let url = URLs.main + "banners"
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
                    let images = try JSONDecoder().decode(banner.self, from: response.data!)
                    if images.status == false {
                        completion(nil,true,images)
                    }else {
                        completion(nil,true,images)
                    }
                }catch{
                    print("error")
                }
            }
        }
        
    }
    
    class func product(url: String,  completion: @escaping(_ error: Error?,_ success: Bool,_ product: Product?)-> Void){
        
        let url = URLs.main + "\(helperLogin.getLangData().mainLangs ?? "")" + "/\(helperLogin.getLangData().mianCountrys ?? "")" + "\(url)"
        
        guard let user_token = helperLogin.getAPIToken() else {
                   completion(nil, false,nil)
                   return
        }
        
        let parametars = [
            "userId": user_token
        ] as [String : Any]
        
               
        print(url)
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let prdouct = try JSONDecoder().decode(Product.self, from: response.data!)
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
    
    class func dellProduct(completion: @escaping(_ error: Error?,_ success: Bool,_ product: DellOfDay?)-> Void){
           
        let url = URLs.main + "\(helperLogin.getLangData().mainLangs ?? "")" + "/\(helperLogin.getLangData().mianCountrys ?? "")" + "/deal"
           
           guard let user_token = helperLogin.getAPIToken() else {
                      completion(nil, false,nil)
                      return
           }
           
           let parametars = [
               "userId": user_token
           ] as [String : Any]
           
                  
           print(url)
           AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
               switch response.result
               {
               case .failure(let error):
                   completion(error, false,nil)
                   print(error)
               case .success:
                   do{
                       print(response)
                       let prdouct = try JSONDecoder().decode(DellOfDay.self, from: response.data!)
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
    
    class func getReviews(productID: String,  completion: @escaping(_ error: Error?,_ success: Bool,_ product: Reviews?)-> Void){
        
        let url = URLs.main + "en" + "/EGP" + "/product/\(productID)"
        
        guard let user_token = helperLogin.getAPIToken() else {
                   completion(nil, false,nil)
                   return
        }
        
        let parametars = [
            "userId": user_token
        ] as [String : Any]
        
               
        print(url)
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let prdouct = try JSONDecoder().decode(Reviews.self, from: response.data!)
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
    
    class func blogsApi(completion: @escaping(_ error: Error?,_ success: Bool,_ blog: blogs?)-> Void){
        
        let url = URLs.main + "en" + "/allBlogs"
        

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
                    let blog = try JSONDecoder().decode(blogs.self, from: response.data!)
                    if blog.status == false {
                        completion(nil,true,blog)
                    }else {
                        completion(nil,true,blog)
                    }
                }catch{
                    print("error")
                }
            }
        }
        
    }
}
