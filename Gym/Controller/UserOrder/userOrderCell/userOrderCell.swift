//
//  userOrderCell.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class userOrderCell: UITableViewCell {
    
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var orderCode: UILabel!
    @IBOutlet weak var shpingPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(userOrder: userOrdersData){
        let OrderID = NSLocalizedString("Order ID:", comment: "")
        orderId.text = "\(OrderID) \(userOrder.id ?? 0)"
        let OrderCode = NSLocalizedString("Order Code:", comment: "")
        orderCode.text = "\(OrderCode) \(userOrder.code ?? 0)"
        let ShippingPrice = NSLocalizedString("Shipping Price:", comment: "")
        shpingPrice.text = "\(ShippingPrice) \(userOrder.shippingPrice ?? 0) \(helperLogin.getLangData().mainCurancys ?? "")"
        let Total = NSLocalizedString("Total:", comment: "")
        totalPrice.text = "\(Total) \(userOrder.total ?? 0) \(helperLogin.getLangData().mainCurancys ?? "")"
        let OrderStatus = NSLocalizedString("Order Status:", comment: "")
        orderStatus.text = "\(OrderStatus) \(userOrder.status ?? "")"
        
        
        
    }
    
    
    
    
}
