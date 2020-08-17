//
//  productsCell.swift
//  Gym
//
//  Created by Ahmed farid on 5/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Cosmos

class productsCell: UICollectionViewCell {
    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var favBTN: UIButton!
    @IBOutlet weak var CartBTN: UIButton!
    @IBOutlet weak var nameTF: UILabel!
    @IBOutlet weak var priceTF: UILabel!
    @IBOutlet weak var rate: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(product: productData){
        rate.rating = Double(product.rate ?? 0)
        nameTF.text = product.title
        priceTF.text = "\(product.sizes?.first?.price ?? "") \(helperLogin.getLangData().mainCurancys ?? "")"
        if product.isFavorite == true {
            favBTN.setImage(UIImage(named: "Group 1"), for: .normal)
        }else {
            favBTN.setImage(UIImage(named: "Group 2"), for: .normal)
        }
        let urlWithoutEncoding = (product.images?[0])
        let encodedLink = urlWithoutEncoding?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        imageProduct.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            imageProduct.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
}
