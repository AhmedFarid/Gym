//
//  dealsOfDayCell.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Cosmos

class dealsOfDayCell: UICollectionViewCell {
    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var favBTN: UIButton!
    @IBOutlet weak var CartBTN: UIButton!
    @IBOutlet weak var nameTF: UILabel!
    @IBOutlet weak var priceTF: UILabel!
    @IBOutlet weak var rate: CosmosView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var hrs: UILabel!
    @IBOutlet weak var min: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(product: dellData){
        rate.rating = Double(product.rate ?? 0)
        nameTF.text = product.title
        priceTF.text = "\(product.sizes?.first?.price ?? "") \(helperLogin.getLangData().mainCurancys ?? "")"
        desc.text = product.dataDescription?.html2String
        day.text = "\(product.day ?? 0)"
        hrs.text = "\(product.hour ?? 0)"
        min.text = "\(product.min ?? 0)"
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
