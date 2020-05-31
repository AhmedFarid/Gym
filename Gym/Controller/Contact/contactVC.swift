//
//  contactVC.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import WebKit

class contactVC: UIViewController {
    
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var phone2: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mapview: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNav(logo: true, menu: true, cart: true, back: false)
        
        setUp()
        
    }
    
    func setUp() {
        contactApi.getContact{ (error,success,contact) in
            if let contact = contact{
                self.address.text = contact.data?.address?.html2String
                self.phone.text = contact.data?.phone1
                self.phone2.text = contact.data?.phone2
                self.email.text = contact.data?.email
                
               
                self.mapview.loadHTMLString(contact.data?.map ?? "", baseURL: nil)
                
            }
            
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "callbackHandler") {
            print("JavaScript is sending a message \(message.body)")
        }
    }
}
