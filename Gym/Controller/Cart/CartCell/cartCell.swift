//
//  cartCell.swift
//  Gym
//
//  Created by Ahmed farid on 5/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class cartCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
        @IBOutlet weak var title: UILabel!
        @IBOutlet weak var price: UILabel!
        @IBOutlet weak var qty: UILabel!
        @IBOutlet weak var minBtn: UIButton!
        @IBOutlet weak var maxBtn: UIButton!
        @IBOutlet weak var clearBTN: UIButton!
        @IBOutlet weak var desc: UILabel!
        
        var add: (()->())?
        var min: (()->())?
        var deleteBtn: (()->())?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            //self.img.layer.cornerRadius = 8.0
            
        }
        
        func configureCell(cart: Item){
            title.text = cart.title
            desc.text = cart.itemDescription?.html2String
            let totalPrice = (Int(cart.price ?? "") ?? 0) * (cart.userQuantity ?? 0)
            price.text = "\(totalPrice) \(helperLogin.getLangData().mainCurancys ?? "")"
            qty.text = "\(cart.userQuantity ?? 0)"
            let urlWithoutEncoding = (cart.images?[0] ?? "")
            let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            let encodedURL = NSURL(string: encodedLink!)! as URL
            img.kf.indicatorType = .activity
            if let url = URL(string: "\(encodedURL)") {
                img.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
            }
        }
        
        @IBAction func clearBTNAction(_ sender: Any) {
            deleteBtn?()
        }
        
        @IBAction func plusBTNAction(_ sender: Any) {
            add?()
        }
        @IBAction func mainBTNAction(_ sender: Any) {
            min?()
        }
       
        
    }
