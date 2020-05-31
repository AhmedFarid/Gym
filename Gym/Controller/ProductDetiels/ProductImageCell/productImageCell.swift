//
//  productImageCell.swift
//  Gym
//
//  Created by Ahmed farid on 5/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class productImageCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(images: String){
        let urlWithoutEncoding = (images)
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        bannerImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            bannerImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
}
