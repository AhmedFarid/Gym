//
//  loginVC.swift
//  Gym
//
//  Created by Ahmed farid on 5/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class loginVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavColore(true)
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        let response = Validation.shared.validate(values:
            (ValidationType.email, emailTF.text ?? "")
            ,(ValidationType.password, passwordTF.text ?? ""))
        switch response {
        case .success:
            startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .black, textColor: .white)
            auhtApi.login(email: emailTF.text ?? "", password: passwordTF.text ?? "") { (error, success, login) in
                if success {
                    if login?.status == false{
                        self.stopAnimating()
                        let title = NSLocalizedString("Login", comment: "")
                        let message = NSLocalizedString("Faild email or password is wrong", comment: "")
                        self.showAlert(title: title, message: message)
                    }else{
                        let login = login?.data
                        print(login?.email ?? "")
                    }
                }else {
                    self.stopAnimating()
                    let title = NSLocalizedString("Login", comment: "")
                    let message = NSLocalizedString("Check your network", comment: "")
                    self.showAlert(title: title, message: message)
                }
            }
            break
        case .failure(_, let message):
            let title = NSLocalizedString("Login", comment: "")
            showAlert(title: title, message: message.localized())
        }
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        let vc = signUpVC(nibName: "signUpVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}
