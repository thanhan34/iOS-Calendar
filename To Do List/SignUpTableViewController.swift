//
//  SignUpTableViewController.swift
//  To Do List
//
//  Created by Doan Thanh An on 4/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class SignUpTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let networkingService = NetworkingService()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func choosePicture(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        let alertController = UIAlertController(title: "Add a picture", message: "Choose From", preferredStyle: .Alert)
        let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler: {
            (action) in
            pickerController.sourceType = .Camera
            self.presentViewController(pickerController, animated: true, completion: nil)
        })
        let photosLibrary = UIAlertAction(title: "Photo Library", style: .Default, handler: {
            (action) in
            pickerController.sourceType = .PhotoLibrary
            self.presentViewController(pickerController, animated: true, completion: nil)
        })
        let savedPhotoAction = UIAlertAction(title: "Saved Photo Album", style: .Default, handler: {
            (action) in
            pickerController.sourceType = .SavedPhotosAlbum
            self.presentViewController(pickerController, animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibrary)
        alertController.addAction(savedPhotoAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.userImageView.image = image
    }
   
    @IBAction func signUpbutton(sender: AnyObject) {
        let data = UIImageJPEGRepresentation(self.userImageView.image!, 0.8)
        
        networkingService.signUp(emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, data: data)
    }

}
