//
//  CustomizableImageView.swift
//  To Do List
//
//  Created by Doan Thanh An on 5/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableImageView: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    
        
    }
    @IBInspectable var borderColor: CGColor = UIColor.blackColor().CGColor {
        didSet{
            layer.borderColor = borderColor
        }
    }
    
}
