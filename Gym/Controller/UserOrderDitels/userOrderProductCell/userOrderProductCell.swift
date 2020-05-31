//
//  userOrderProductCell.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class userOrderProductCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 
    
    
    func configureCell(userOrder: UserOrdersDetilesProductData){
        titleProduct.text = userOrder.title
        let ProductQuantity = NSLocalizedString("Product Quantity:", comment: "")
        quantity.text = "\(ProductQuantity) \(userOrder.quantity ?? 0)"
        let TotalPrice = NSLocalizedString("Total Price:", comment: "")
        price.text = "\(TotalPrice) \((Double(userOrder.price ?? "") ?? 0.0 ) * Double(userOrder.quantity ?? 0)) \(helperLogin.getLangData().mainCurancys ?? "")"
        
        let urlWithoutEncoding = ("https://salemsaber.com/websites/dabberha_dynamic/public/upload/\(userOrder.image ?? "")")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        productImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            productImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
}
