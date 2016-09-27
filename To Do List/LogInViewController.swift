//
//  ViewController.swift
//  To Do List
//
//  Created by Doan Thanh An on 4/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: CustomizableTextField!
    @IBOutlet weak var passwordTextField: CustomizableTextField!
    let netWorkingService = NetworkingService()
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToLogIn(storyboard: UIStoryboardSegue){
    
    }
    
    @IBAction func logInAction(sender: AnyObject) {
        self.view.endEditing(true)
        netWorkingService.signIn(emailTextField.text!, password: passwordTextField.text!)
        
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    

}
