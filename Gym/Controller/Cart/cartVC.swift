//
//  cartVC.swift
//  Gym
//
//  Created by Ahmed farid on 5/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class cartVC: UIViewController,NVActivityIndicatorViewable {
    
    var fromMnue = false
    
    var liCart = [Item]()
    var totalPrice = 0.0
    var totalCartPrice = 0.0
    
    
    @IBOutlet weak var cartTabelView: UITableView!
    @IBOutlet weak var totlaPrice: UILabel!
    @IBOutlet weak var createOrderBTN: costomButton!
    @IBOutlet weak var topTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cartTabelView.register(UINib.init(nibName: "cartCell", bundle: nil), forCellReuseIdentifier: "cell")
        cartTabelView.delegate = self
        cartTabelView.dataSource = self
        
        cartHandelRefresh()
        
        
        if fromMnue == false {
            setUpNav(logo: true, menu: false, cart: false, back: true)
        }else {
            setUpNav(logo: true, menu: true, cart: false, back: false)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartHandelRefresh()
    }
    
    func cartHandelRefresh(){
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        cartApi.cartList{ (error,success,liCart) in
            if liCart?.status == true {
                if let liCart = liCart{
                    self.liCart = liCart.data?.items ?? []
                    print("zzzz\(liCart)")
                    self.totlaPrice.text = "\(liCart.data?.totalPrice ?? 0) \(helperLogin.getLangData().mainCurancys ?? "")"
                    self.totalCartPrice = liCart.data?.totalPrice ?? 0.0
                    let Items = NSLocalizedString("Items", comment: "")
                    let TotalCost = NSLocalizedString("Total Cost", comment: "")
                    self.topTotal.text = "\(self.liCart.count) \(Items) / \(TotalCost) \(liCart.data?.totalPrice ?? 0) \(helperLogin.getLangData().mainCurancys ?? "")"
                    if self.liCart.count == 0 {
                        self.stopAnimating()
                        let Cart = NSLocalizedString("Cart", comment: "")
                        let message = NSLocalizedString("Error Cart", comment: "")
                        self.showAlert(title: Cart, message: message)
                        self.createOrderBTN.isHidden = true
                        self.totlaPrice.text = ""
                    }
                    self.cartTabelView.reloadData()
                    self.stopAnimating()
                }else {
                    self.stopAnimating()
                    let Cart = NSLocalizedString("Cart", comment: "")
                    let message = NSLocalizedString("Error Cart", comment: "")
                    self.showAlert(title: Cart, message: message)
                    self.createOrderBTN.isHidden = true
                    self.totlaPrice.text = ""
                }
            }else {
                self.stopAnimating()
                let Cart = NSLocalizedString("Cart", comment: "")
                let message = NSLocalizedString("Error Cart", comment: "")
                self.showAlert(title: Cart, message: message)
                self.createOrderBTN.isHidden = true
                self.totlaPrice.text = ""
            }
            
        }
    }
    
    func optionCart(quantity: String, productId: String) {
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        cartApi.optionCarts(productId: productId, quantity: quantity){ (error, success, addTofav) in
            if success {
                self.stopAnimating()
                let Cart = NSLocalizedString("Cart", comment: "")
                self.showAlert(title: Cart, message: addTofav?.data ?? "")
                self.cartTabelView.reloadData()
            }else {
                let title = NSLocalizedString("Cart", comment: "")
                let message = NSLocalizedString("Check your network", comment: "")
                self.showAlert(title: title, message: message)
                self.stopAnimating()
                self.cartTabelView.reloadData()
            }
        }
    }
    
    func removeFromCart( productId: String) {
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        cartApi.removerCart(productId: productId){ (error, success, addTofav) in
            if success {
                self.stopAnimating()
                let title = NSLocalizedString("Cart", comment: "")
                self.showAlert(title: title, message: addTofav?.data ?? "")
                self.cartTabelView.reloadData()
            }else {
                let title = NSLocalizedString("Cart", comment: "")
                let message = NSLocalizedString("Check your network", comment: "")
                self.showAlert(title: title, message: message)
                self.stopAnimating()
                self.cartTabelView.reloadData()
            }
        }
    }
    
    @IBAction func checkOutBTN(_ sender: Any) {
        let vc = checkOutVC(nibName: "checkOutVC", bundle: nil)
        vc.totalCart = liCart.count
        vc.totalCartPrices = totalCartPrice
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}


extension cartVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = cartTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? cartCell {
            cell.configureCell(cart: liCart[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            if self.liCart[indexPath.row].userQuantity == 1{
                cell.minBtn.isHidden = true
            }else {
                cell.minBtn.isHidden = false
            }
            
            cell.add = {
                self.optionCart(quantity: "\((self.liCart[indexPath.row].userQuantity ?? 0) + 1)", productId: "\(self.liCart[indexPath.row].id ?? 0)")
                self.cartHandelRefresh()
            }
            
            cell.deleteBtn = {
                self.removeFromCart(productId: "\(self.liCart[indexPath.row].id ?? 0)")
                self.cartHandelRefresh()
                if self.liCart.count == 1{
                    self.liCart.removeAll()
                    self.createOrderBTN.isHidden = true
                    self.totlaPrice.text = ""
                    self.cartHandelRefresh()
                }
            }
            
            cell.min = {
                self.optionCart(quantity: "\((self.liCart[indexPath.row].userQuantity ?? 0) - 1)", productId: "\(self.liCart[indexPath.row].id ?? 0)")
                self.cartHandelRefresh()
            }
            
            return cell
        }else {
            return cartCell()
        }
    }
}



