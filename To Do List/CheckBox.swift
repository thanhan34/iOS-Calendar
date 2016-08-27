//
//  CheckBox.swift
//  To Do List
//
//  Created by Doan Thanh An on 28/08/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    // images
    let checkedImage = UIImage(named: "checked_checkbox")
    let uncheckedImage = UIImage(named: "unchecked_checkbox")
    // bool property
    
    var isChecked: Bool = false{
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, forState: .Normal)
            } else {
                self.setImage(uncheckedImage, forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(CheckBox.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    func buttonClicked(sender: UIButton){
        if (sender == self){
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }
}
