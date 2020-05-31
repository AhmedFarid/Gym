//
//  costomButton.swift
//  Gym
//
//  Created by Ahmed farid on 5/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit


@IBDesignable
class costomButton: UIButton {
    
    @IBInspectable var roudnCornr: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = self.layer.bounds.height/2
        }
    }
    
    @IBInspectable var cornerRadiuscostom: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadiuscostom
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor : UIColor = UIColor.clear{
        didSet{
            self.layer.shadowColor  = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity : Float = 0{
        didSet{
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset  : CGSize = CGSize.zero{
        didSet{
            self.layer.shadowOffset  = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius : CGFloat = 0{
        didSet{
            self.layer.shadowRadius  = shadowRadius
        }
    }
    
    @IBInspectable var cornerCostomReduse : CGFloat = 0{
        didSet{
            self.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        }
    }
}
