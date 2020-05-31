//
//  reviewsCell.swift
//  Gym
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Cosmos

class reviewsCell: UITableViewCell {
    
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var reate: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(product: Review){
        reate.rating = Double(product.rate ?? "") ?? 0.0
        nameTitle.text = product.name
        desc.text = product.reviewDescription
        
    }
    
    func configureCellForAbout(product: aboutReview){
        reate.rating = Double(product.rate ?? "") ?? 0.0
        nameTitle.text = product.name
        desc.text = product.reviewDescription
        
    }
}
