//
//  userOrderDitelsVC.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class userOrderDitelsVC: UIViewController, NVActivityIndicatorViewable {
    
    
    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var orderCode: UILabel!
    @IBOutlet weak var shoppingPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var prdouctTableView: UITableView!
    
    var userOrde = [UserOrdersDetilesProductData]()
    var singelItem: userOrdersData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNav(logo: true, menu: false, cart: true, back: true)
        setUpNavColore(false)
        // Do any additional setup after loading the view.
        
        prdouctTableView.delegate = self
        prdouctTableView.dataSource = self
        
        prdouctTableView.register(UINib(nibName: "userOrderProductCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        prdouctTableView.rowHeight = UITableView.automaticDimension
        prdouctTableView.estimatedRowHeight = UITableView.automaticDimension
        
        userOrderProductHandelRefresh()
        
    }
    
    func userOrderProductHandelRefresh(){
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        userOrderApi.getAllUserOrderDiteals(orderId: singelItem?.id ?? 0){ (error,success,userOrde) in
            if let userOrde = userOrde{
                self.userOrde = userOrde.data?.products ?? []
                self.prdouctTableView.reloadData()
                let OrderID = NSLocalizedString("Order ID:", comment: "")
                self.orderID.text = "\(OrderID) \(userOrde.data?.id ?? 0)"
                let OrderCode = NSLocalizedString("Order Code:", comment: "")
                self.orderCode.text = "\(OrderCode) \(userOrde.data?.code ?? 0)"
                let ShippingPrice = NSLocalizedString("Shipping Price:", comment: "")
                self.shoppingPrice.text = "\(ShippingPrice) \(userOrde.data?.shippingPrice ?? 0) \(helperLogin.getLangData().mainCurancys ?? "")"
                let Total = NSLocalizedString("Total:", comment: "")
                self.totalPrice.text = "\(Total) \(userOrde.data?.total ?? 0) \(helperLogin.getLangData().mainCurancys ?? "")"
                let OrderStatus = NSLocalizedString("Order Status:", comment: "")
                self.orderStatus.text = "\(OrderStatus) \(userOrde.data?.status ?? "")"
                print(userOrde.data?.products ?? [])
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
}


extension userOrderDitelsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userOrde.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = prdouctTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? userOrderProductCell {
            cell.configureCell(userOrder: userOrde[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return userOrderProductCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
