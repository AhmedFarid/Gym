//
//  blogsCell.swift
//  Gym
//
//  Created by Ahmed farid on 5/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class blogsCell: UICollectionViewCell {
    
    @IBOutlet weak var blogImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(blogs: blogsData){
        name.text = blogs.title
        desc.text = blogs.datumDescription?.html2String
        let urlWithoutEncoding = (blogs.image)
        let encodedLink = urlWithoutEncoding?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        blogImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            blogImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
}

