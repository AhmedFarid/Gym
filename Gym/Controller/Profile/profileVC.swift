//
//  profileVC.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class profileVC: UIViewController, NVActivityIndicatorViewable{
    
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var editBtn: costomButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNav(logo: true, menu: true, cart: false, back: false)
        setUpNavEdit()
        profileHandelRefresh()
    }
    
    func setUpNavEdit() {
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "edit white-1"), style: .done, target: self, action: #selector(profileVC.showUpdate))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    
    func profileHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .black, textColor: .white)
        userProfileApi.getPrifle{ (error,networkSuccess,profile) in
            if let profile = profile?.data{
                self.fullNameTF.text = profile.name
                self.phoneTF.text = profile.phone
                self.addressTF.text = profile.address
                self.emailTF.text = profile.email
                self.stopAnimating()
            }else {
                self.stopAnimating()
                self.showAlert(title: "Error", message: "Error profile")
            }
            
        }
    }
    
    
    @objc func showUpdate() {
        editBtn.isHidden = false
        fullNameTF.isEnabled = true
        phoneTF.isEnabled = true
        addressTF.isEnabled = true
        emailTF.isEnabled = true
        oldPassword.isEnabled = true
        newPassword.isEnabled = true
        
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "edit white-1"), style: .done, target: self, action: #selector(profileVC.hideCart))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func hideCart() {
        editBtn.isHidden = true
        fullNameTF.isEnabled = false
        phoneTF.isEnabled = false
        addressTF.isEnabled = false
        emailTF.isEnabled = false
        oldPassword.isEnabled = false
        newPassword.isEnabled = false
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "edit white-1"), style: .done, target: self, action: #selector(profileVC.showUpdate))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    
    
    
    
    
    @IBAction func editBTN(_ sender: Any) {
        
        guard let emailA = emailTF.text, !emailA.isEmpty else {
            let messages = NSLocalizedString("enter your country", comment: "hhhh")
            let title = NSLocalizedString("Edit Profile", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let phones = phoneTF.text, !phones.isEmpty else {
            let messages = NSLocalizedString("enter your  phone", comment: "hhhh")
            let title = NSLocalizedString("Edit Profile", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        
        guard let name = fullNameTF.text, !name.isEmpty else {
            let messages = NSLocalizedString("enter your full name", comment: "hhhh")
            let title = NSLocalizedString("Edit Profile", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let address = addressTF.text, !address.isEmpty else {
            let messages = NSLocalizedString("enter your address", comment: "hhhh")
            let title = NSLocalizedString("Edit Profile", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .black, textColor: .white)
        userProfileApi.upadateProfile(name: name, phone: phones, email: emailA, address: address, password:  newPassword.text ?? "" , old_password: oldPassword.text ?? ""){ (error, success, addTofav) in
            if success {
                self.stopAnimating()
                self.showAlert(title: "Profile", message: addTofav?.error ?? "")
                self.editBtn.isHidden = true
                self.fullNameTF.isEnabled = false
                self.phoneTF.isEnabled = false
                self.addressTF.isEnabled = false
                self.emailTF.isEnabled = false
                self.oldPassword.isEnabled = false
                self.newPassword.isEnabled = false
                let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "edit white-1"), style: .done, target: self, action: #selector(profileVC.showUpdate))
                self.navigationItem.rightBarButtonItem = rightBarButtonItem
                self.profileHandelRefresh()
            }else {
                self.showAlert(title: "Profile", message: "Check your network")
                self.stopAnimating()
                self.editBtn.isHidden = true
                self.fullNameTF.isEnabled = false
                self.phoneTF.isEnabled = false
                self.addressTF.isEnabled = false
                self.emailTF.isEnabled = false
                self.oldPassword.isEnabled = false
                self.newPassword.isEnabled = false
                let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "edit white-1"), style: .done, target: self, action: #selector(profileVC.showUpdate))
                self.navigationItem.rightBarButtonItem = rightBarButtonItem
                self.profileHandelRefresh()
            }
        }
        
    }
    
}
