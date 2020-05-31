//
//  signUpVC.swift
//  Gym
//
//  Created by Ahmed farid on 5/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class signUpVC: UIViewController, NVActivityIndicatorViewable {
    
    var hide:Bool = true
    
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var addressTf: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func signUPBTN(_ sender: Any) {
        let response = Validation.shared.validate(values:(ValidationType.alphabeticString, fullNameTF.text ?? ""),(ValidationType.phoneNo, phoneTF.text ?? ""),(ValidationType.email, emailTF.text ?? ""),(ValidationType.password, passwordTF.text ?? ""),(ValidationType.passwordCoinformation, confirmPassword.text ?? ""))
        switch response {
        case .success:
            
            guard passwordTF.text == confirmPassword.text else {
                let title = NSLocalizedString("Sign Up", comment: "")
                let message = NSLocalizedString("Password and confirm password not match", comment: "")
                self.showAlert(title: title, message: message)
                return
                
            }
            
            guard let address = addressTf.text, !address.isEmpty else {
                let title = NSLocalizedString("Sign Up", comment: "")
                let message = NSLocalizedString("Please enter your Address", comment: "")
                self.showAlert(title: title, message: message)
                return
            }

            let Loading = NSLocalizedString("Loading...", comment: "")
            startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
            auhtApi.register(name: fullNameTF.text ?? "", phone: phoneTF.text ?? "", email: emailTF.text ?? "", password: passwordTF.text ?? "",address: address, confirm_password: confirmPassword.text ?? "") { (error, success, Register) in
                if success {
                    if Register?.status == false{
                        let title = NSLocalizedString("Sign Up", comment: "")
                        let message = NSLocalizedString("Faild your mail or phone is used", comment: "")
                        self.showAlert(title: title, message: message)
                        self.stopAnimating()
                    }else{
                        let login = Register?.data
                        print(login?.email ?? "")
                    }
                }else {
                    let title = NSLocalizedString("Sign Up", comment: "")
                    let message = NSLocalizedString("Check your network", comment: "")
                    self.showAlert(title: title, message: message)
                    self.stopAnimating()
                }
                
            }
            break
        case .failure(_, let message):
            let title = NSLocalizedString("Sign Up", comment: "")
            showAlert(title: title, message: message.localized())
        }
    }
}
