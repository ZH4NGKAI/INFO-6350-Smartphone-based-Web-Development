//
//  CustomButton.swift
//  Assignment_6
//
//  Created by mac on 3/17/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton : UIButton{
    @IBInspectable var borderCorner: CGFloat = 15.0{
        didSet{
            self.layer.cornerRadius = borderCorner
        }
    }
    @IBInspectable var borderThickness:CGFloat = 2.0{
        didSet{
            self.layer.borderWidth = borderThickness
        }
    }
    @IBInspectable var borderColor:UIColor = UIColor.white{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
