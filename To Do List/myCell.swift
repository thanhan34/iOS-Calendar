//
//  myCell.swift
//  To Do List
//
//  Created by Doan Thanh An on 29/07/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class myCell: UITableViewCell {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
