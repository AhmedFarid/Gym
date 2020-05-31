//
//  checkOutVC.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class checkOutVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var area: UITextField!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var totalCartPrice: UILabel!
    @IBOutlet weak var shiping: UILabel!
    @IBOutlet weak var totalALl: UILabel!
    
    
    var totalCart = 0
    var totalCartPrices = 0.0
    var servicesId = 0
    
    var categoriesData = [shippingCategoriesData]()
    var servicesData = [shippingServicesData]()
    
    let areaPickerView = UIPickerView()
    let cityPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        creatCityPiker()
        setUpView()
    }
    
    func setUpView() {
        let Product = NSLocalizedString("Product", comment: "")
        totalPrice.text = "\(totalCart) \(Product)"
        totalCartPrice.text = "\(totalCartPrices) \(helperLogin.getLangData().mainCurancys ?? "")"
        self.totalALl.text = "\(totalCartPrices) \(helperLogin.getLangData().mainCurancys ?? "")"
    }
    
    
    func creatCityPiker() {
        cityTF.isEnabled = false
        area.isEnabled = false
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        cityTF.inputView = cityPickerView
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        checkOutApi.getAllShippingCategories{ (error,success,categoriesData) in
            if let categoriesData = categoriesData{
                self.categoriesData = categoriesData.data ?? []
                self.cityPickerView.reloadAllComponents()
                self.cityTF.isEnabled = true
                self.stopAnimating()
            }
            self.stopAnimating()
        }
        
    }
    
    func areaCityPiker(Id: Int) {
        
        areaPickerView.delegate = self
        areaPickerView.dataSource = self
        area.inputView = areaPickerView
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        checkOutApi.getAllShippingServices(shippingCategoriesId: Id){ (error,success,servicesData) in
            if let servicesData = servicesData{
                self.servicesData = servicesData.data ?? []
                self.areaPickerView.reloadAllComponents()
                self.area.isEnabled = true
                self.stopAnimating()
            }
            self.stopAnimating()
        }
        
    }
    
    
    @IBAction func checkOut(_ sender: Any) {
        
        guard let areaTF = area.text, !areaTF.isEmpty else {
            let title = NSLocalizedString("Order", comment: "")
            let message = NSLocalizedString("Please enter your Area And City", comment: "")
            self.showAlert(title: title, message: message)
            return
        }
        
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .black, textColor: .white)
        checkOutApi.submitOrder(shippingId: servicesId){ (error, success, message) in
            if success {
                self.stopAnimating()
                let title = NSLocalizedString("Order", comment: "")
                let messages = NSLocalizedString("Your Order ID Is", comment: "")
                let alert = UIAlertController(title: title, message: "\(message?.data?.message ?? "")\n \(messages) \(message?.data?.orderID ?? 0)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                    let vc = homeVC(nibName: "homeVC", bundle: nil)
                    self.navigationController!.pushViewController(vc, animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                
            }else {
                let title = NSLocalizedString("Order", comment: "")
                let message = NSLocalizedString("Check your network", comment: "")
                self.showAlert(title: title, message: message)
                self.stopAnimating()
            }
        }
    }
}

extension checkOutVC: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cityPickerView{
            return categoriesData.count
        }else{
            return servicesData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cityPickerView{
            return categoriesData[row].name
        }else{
            return servicesData[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cityPickerView{
            if categoriesData.count != 0 {
                self.cityTF.text = categoriesData[row].name
                areaCityPiker(Id: categoriesData[row].id ?? 0)
            }
        }else{
            if servicesData.count != 0 {
                self.area.text = servicesData[row].name
                self.shiping.text = "\(servicesData[row].cost ?? "") \(helperLogin.getLangData().mainCurancys ?? "")"
                self.servicesId = servicesData[row].id ?? 0
                self.totalALl.text = "\((Double(servicesData[row].cost ?? "") ?? 0.0) + (totalCartPrices)) \(helperLogin.getLangData().mainCurancys ?? "")"
            }
        }
    }
}

