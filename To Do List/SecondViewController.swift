//
//  SecondViewController.swift
//  To Do List
//
//  Created by Rob Percival on 16/01/2015.
//  Copyright (c) 2015 Appfish. All rights reserved.
//

import UIKit


class SecondViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var titletextField: UITextField!
    @IBOutlet weak var staffTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var repeatTextField: UITextField!
    @IBOutlet weak var importedImage: UIImageView!
    @IBOutlet weak var secondPhoto: UIImageView!
    @IBOutlet var item: UITextField!
   // var imageInput: UIImageView!
    
    var isFromFirst: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.item.delegate = self
        self.startDate.delegate = self
        self.endDate.delegate = self
        importedImage.image = UIImage(named: "images.jpg")
        
        ScrollView.contentSize.height = 600
        
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        
        let datePicker = UIDatePicker()
        startDate.inputView = datePicker
        endDate.inputView = datePicker
        //textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(SecondViewController.datePickerChanged(_:)), forControlEvents: .ValueChanged)
    }
    
    
    func datePickerChanged(sender: UIDatePicker){
        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        if ( startDate.editing){
        startDate.text = formatter.stringFromDate(sender.date)
        }
        if (endDate.editing){
            endDate.text = formatter.stringFromDate(sender.date)
        }
       
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [NSObject : AnyObject]?) {
        print("Image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        if (self.isFromFirst) {
            importedImage.image = image
        }
        else {
            secondPhoto.image = image
        }
       // imageInput.image = image
       // secondPhoto.image = image
    }
    
    // MARK: - Action Sheet
    
    
    @IBAction func showActionSheet1(sender: AnyObject) {
        
        self.isFromFirst = true
        let image = UIImagePickerController()
        image.delegate = self
        let actionSheet = UIAlertController(title: "Action Sheet", message: "Choose Option", preferredStyle: .ActionSheet)
        let libButton = UIAlertAction(title: "Select from photo library", style: .Default, handler: { (libButton) -> Void in
            image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            image.allowsEditing = false
          //  self.imageInput = self.importedImage
            self.presentViewController(image, animated: true, completion: nil)
        
        })
        let cameraButton = UIAlertAction(title: "Take picture", style: .Default, handler: { (cameraButton) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            image.sourceType = UIImagePickerControllerSourceType.Camera
            image.allowsEditing = false
            self.presentViewController(image, animated: true, completion: nil)
            }
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: {(cancelButton) -> Void in
            print("Cancel selected")
        })
        actionSheet.addAction(libButton)
        actionSheet.addAction(cameraButton)
        actionSheet.addAction(cancelButton)
        
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func showActionSheet2(sender: AnyObject) {
        self.isFromFirst = false
        let image1 = UIImagePickerController()
        image1.delegate = self
        
        let actionSheet = UIAlertController(title: "Action Sheet", message: "Choose Option", preferredStyle: .ActionSheet)
        let libButton = UIAlertAction(title: "Select from photo library", style: .Default, handler: { (libButton) -> Void in
            image1.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            image1.allowsEditing = false
          //  self.imageInput = self.secondPhoto
            self.presentViewController(image1, animated: true, completion: nil)
            
        })
        let cameraButton = UIAlertAction(title: "Take picture", style: .Default, handler: { (cameraButton) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                
                image1.sourceType = UIImagePickerControllerSourceType.Camera
                image1.allowsEditing = false
                self.presentViewController(image1, animated: true, completion: nil)
            }
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: {(cancelButton) -> Void in
            print("Cancel selected")
        })
        actionSheet.addAction(libButton)
        actionSheet.addAction(cameraButton)
        actionSheet.addAction(cancelButton)
        
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
   
    
    @IBAction func addEvent(sender: AnyObject) {
        
        //(title: String,staff:String, location: String,starts: String, ends: String, rpeat: String, imageName: UIImage?, description: String, secondPhoto: UIImage?)
        
        let photo = importedImage.image
        
        let todoItemCreated = ToDoItem(title: titletextField.text!, staff: staffTextField.text!, location: locationTextField.text!, starts: startDate.text!, ends: endDate.text!, rpeat: repeatTextField.text!, imageName: photo, description: item.text!, secondPhoto: photo)
        //let todoItemCreated = ToDoItem(imageName: photo, description: item.text!)
            
         //   imageName: photo, description: item.text!)
        print(todoItemCreated.starts)
        toDoList.append(todoItemCreated)
        print("finish added")
        
        item.text = ""
        importedImage.image = UIImage(named: "images.jpg")
        // NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")
        //NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "arraytodolist")
        
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
   /* override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    */
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //startDate.resignFirstResponder()
        //endDate.resignFirstResponder()
        //item.resignFirstResponder()
        textField.resignFirstResponder()
        return true
        
    }
    

}

