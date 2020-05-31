//
//  userOrderVC.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class userOrderVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var userOrderTabelView: UITableView!
    
    var userOrders = [userOrdersData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNav(logo: true, menu: true, cart: true, back: false)
        setUpNavColore(false)
        // Do any additional setup after loading the view.
        
        userOrderTabelView.delegate = self
        userOrderTabelView.dataSource = self
        
        userOrderTabelView.register(UINib(nibName: "userOrderCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        userOrderTabelView.rowHeight = UITableView.automaticDimension
        userOrderTabelView.estimatedRowHeight = UITableView.automaticDimension
        
        userOrderHandelRefresh()
        
    }
    
    
    func userOrderHandelRefresh(){
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        userOrderApi.getAllUserOrder{ (error,success,userOrders) in
            if let userOrders = userOrders{
                self.userOrders = userOrders.data ?? []
                self.userOrderTabelView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
}

extension userOrderVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = userOrderTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? userOrderCell {
            cell.configureCell(userOrder: userOrders[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return userOrderCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = userOrderDitelsVC(nibName: "userOrderDitelsVC", bundle: nil)
        vc.singelItem = userOrders[indexPath.row]
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}
