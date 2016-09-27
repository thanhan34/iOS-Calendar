//
//  ResetPasswordViewController.swift
//  To Do List
//
//  Created by Doan Thanh An on 4/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: CustomizableTextField!
    let networkingService = NetworkingService()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetPasswordAction(sender: AnyObject) {
        networkingService.resetPassword(emailTextField.text!)
    }
}
