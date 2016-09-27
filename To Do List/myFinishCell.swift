//
//  myFinishCell.swift
//  To Do List
//
//  Created by Doan Thanh An on 12/08/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class myFinishCell: UITableViewCell {

    @IBOutlet weak var speaker: UIButton!
    @IBOutlet weak var checkbox: CheckBox!
    @IBOutlet weak var myFinishImageView: UIImageView!
    @IBOutlet weak var myFinishLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
