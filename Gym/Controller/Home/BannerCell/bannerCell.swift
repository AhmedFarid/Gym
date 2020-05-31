//
//  bannerCell.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class bannerCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(images: bannerData){
        let urlWithoutEncoding = (images.image!)
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        bannerImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            bannerImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
}
