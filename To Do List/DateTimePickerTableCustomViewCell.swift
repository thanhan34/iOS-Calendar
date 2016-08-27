//
//  DateTimePickerTableCustomViewCell.swift
//  To Do List
//
//  Created by Doan Thanh An on 23/08/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class DateTimePickerTableCustomViewCell: UITableViewCell {

    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBAction func dateTimePickerControl(sender: AnyObject) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
