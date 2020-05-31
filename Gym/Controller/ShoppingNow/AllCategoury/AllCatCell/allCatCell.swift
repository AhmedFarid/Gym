//
//  allCatCell.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class allCatCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.catImage.layer.cornerRadius = 8
        self.backView.layer.cornerRadius = 8
    }
    
    func configureCell(cat: categoryData){
        title.text = cat.title
        let urlWithoutEncoding = (cat.image ?? "")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        catImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            catImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
    

}
