//
//  CustomizableButton.swift
//  To Do List
//
//  Created by Doan Thanh An on 5/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }

}
