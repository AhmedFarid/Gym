//
//  blogsDetialsVC.swift
//  Gym
//
//  Created by Ahmed farid on 5/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class blogsDetialsVC: UIViewController {

    @IBOutlet weak var blogImage: UIImageView!
    @IBOutlet weak var titleBloge: UILabel!
    @IBOutlet weak var descBlog: UILabel!
    
    
    var singleBlogs: blogsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
    
    func setUp() {
        titleBloge.text = singleBlogs?.title?.html2String
        descBlog.text = singleBlogs?.datumDescription?.html2String
        
        let urlWithoutEncoding = (singleBlogs?.image ?? "")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        blogImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            blogImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }


  

}
