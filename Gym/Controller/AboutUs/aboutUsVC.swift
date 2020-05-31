//
//  aboutUsVC.swift
//  Gym
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class aboutUsVC: UIViewController {
    
    @IBOutlet weak var aboutImage: UIImageView!
    @IBOutlet weak var aboutTitle: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var reviewsTabelView: UITableView!
    
    var reviews = [aboutReview]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNav(logo: true, menu: true, cart: true, back: false)
        
        reviewsTabelView.delegate = self
        reviewsTabelView.dataSource = self
        
        reviewsTabelView.rowHeight = UITableView.automaticDimension
        reviewsTabelView.estimatedRowHeight = UITableView.automaticDimension
        
        self.reviewsTabelView.register(UINib.init(nibName: "reviewsCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        setUp()
        
    }
    
    
    func setUp() {
        aboutUsAPi.getAbout{ (error,success,reviews) in
            if let reviews = reviews{
                self.reviews = reviews.data?.reviews ?? []
                self.aboutTitle.text = reviews.data?.about?.html2String
                self.desc.text = reviews.data?.dataDescription?.html2String
                
                let urlWithoutEncoding = (reviews.data?.image)
                let encodedLink = urlWithoutEncoding?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
                let encodedURL = NSURL(string: encodedLink!)! as URL
                self.aboutImage.kf.indicatorType = .activity
                if let url = URL(string: "\(encodedURL)") {
                    self.aboutImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
                }
                
                print(reviews)
                self.reviewsTabelView.reloadData()
                //self.stopAnimating()
            }
            //self.stopAnimating()
        }
    }
}

extension aboutUsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = reviewsTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? reviewsCell {
            cell.configureCellForAbout(product: reviews[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return reviewsCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

