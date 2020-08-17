//
//  productSizesCell.swift
//  Dabberha
//
//  Created by Ahmed farid on 8/16/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class productSizesCell: UICollectionViewCell {

    @IBOutlet weak var bacview: coustomRoundedView!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(product: ProductSize){
        
        qty.text = "Quantity: \(product.quantity!)"
        price.text = "Price: \(product.price ?? "") \(helperLogin.getLangData().mainCurancys ?? "")"
        
    }
    
    override var isSelected: Bool {
        didSet{
            bacview.borderColor = isSelected ?  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.5450980392, green: 0.5450980392, blue: 0.5450980392, alpha: 1)
            bacview.borderWidth = isSelected ?  3 : 0
        }
    }

}
