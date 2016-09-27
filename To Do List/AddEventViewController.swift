//
//  SecondViewController.swift
//  To Do List
//
//  Created by Rob Percival on 16/01/2015.
//  Copyright (c) 2015 Appfish. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AddEventViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
   
    var eventname = ""
    var eventimage = UIImage()
    
    var isFromFirst: Bool = false
    var isCompleted: Bool = false
    
    var picker = UIPickerView()
    var RepeatEvent = ["Daily","Every Week","Never"]
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    var storageRef: FIRStorageReference! {
        return FIRStorage.storage().reference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.titletextField.delegate = self
        self.staffTextField.delegate = self
        self.locationTextField.delegate = self
        self.item.delegate = self
        self.startDate.delegate = self
        self.endDate.delegate = self
        importedImage.image = UIImage(named: "images.jpg")
        secondPhoto.image = UIImage(named: "images.jpg")
        
        picker.delegate = self
        picker.dataSource = self
        repeatTextField.inputView = picker
        
        ScrollView.contentSize.height = 600
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddEventViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        ScrollView.addGestureRecognizer(tapGesture)
        
        titletextField.text = eventname
        importedImage.image = eventimage
        
        
        
    }
    
    func hideKeyboard(){
        titletextField.resignFirstResponder()
        staffTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        startDate.resignFirstResponder()
        endDate.resignFirstResponder()
        repeatTextField.resignFirstResponder()
        item.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        
        let datePicker = UIDatePicker()
        startDate.inputView = datePicker
        endDate.inputView = datePicker
        //textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(AddEventViewController.datePickerChanged(_:)), forControlEvents: .ValueChanged)
       
        if (textField == item){
        ScrollView.setContentOffset(CGPointMake(0, 280), animated: true)
        }
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        ScrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    func datePickerChanged(sender: UIDatePicker){
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .ShortStyle
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
    }
    
    // MARK: - Alert Sheet
    
    
  /*  @IBAction func showActionSheet1(sender: AnyObject) {
        
        self.isFromFirst = true
        let image = UIImagePickerController()
        image.delegate = self
        let actionSheet = UIAlertController(title: "Choose image from", message: "Choose Option", preferredStyle: .Alert)
        let libButton = UIAlertAction(title: "Select from photo library", style: .Default, handler: { (libButton) -> Void in
            image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            image.allowsEditing = true
            self.presentViewController(image, animated: true, completion: nil)
        
        })
        let cameraButton = UIAlertAction(title: "Take picture", style: .Default, handler: { (cameraButton) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            image.sourceType = UIImagePickerControllerSourceType.Camera
            image.allowsEditing = true
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
        
    }*/
    
    @IBAction func showActionSheet2(sender: AnyObject) {
        self.isFromFirst = false
        let image1 = UIImagePickerController()
        image1.delegate = self
        
        
        
        let actionSheet = UIAlertController(title: "Choose image from", message: "Choose Option", preferredStyle: .Alert)
        let libButton = UIAlertAction(title: "Select from photo library", style: .Default, handler: { (libButton) -> Void in
            image1.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            image1.allowsEditing = true
            self.presentViewController(image1, animated: true, completion: nil)
            
        })
        let cameraButton = UIAlertAction(title: "Take picture", style: .Default, handler: { (cameraButton) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                
                image1.sourceType = UIImagePickerControllerSourceType.Camera
                image1.allowsEditing = true
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
        let data = UIImageJPEGRepresentation(self.importedImage.image!, 0.4)
        let data1 = UIImageJPEGRepresentation(self.secondPhoto.image!, 0.4)
        
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let metadata1 = FIRStorageMetadata()
        metadata1.contentType = "image/jpeg"
        
        let eventID = "\(FIRAuth.auth()!.currentUser!.uid)\(NSUUID().UUIDString)"
        let imagePath = "postImages/\(eventID)/postPic1.jpg"
        let imagePath1 = "postImages/\(eventID)/postPic2.jpg"
        
        storageRef.child(imagePath).putData(data!, metadata: metadata)
        { (metadata, error) in
            if error == nil
            {
                self.storageRef.child(imagePath1).putData(data1!, metadata: metadata1)
                { (metadata1, error1) in
                    if error1 == nil
                    {
                        let eventRef = self.databaseRef.child("posts").childByAutoId()
                        let event = TodoItemDatabase(username: FIRAuth.auth()!.currentUser!.displayName!,
                                             eventID: eventID,
                                             title: self.titletextField.text!,
                                             staff: self.staffTextField.text!,
                                             location: self.locationTextField.text!,
                                             starts: self.startDate.text!,
                                             ends: self.endDate.text!,
                                             rpeat: self.repeatTextField.text!,
                                             imageName: String(metadata!.downloadURL()!),
                                             description: self.item.text!,
                                             secondPhoto: String(metadata1!.downloadURL()!),
                                             isCompleted: self.isCompleted)
                        eventRef.setValue(event.toAnyObject())
                    }//end if 2
                    else
                    {
                        print(error1!.localizedDescription)
                    }//end else
                }// end metadata 2
                
            }//end if 1
            else
            {
                print(error!.localizedDescription)
            }
        
        }
    
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let showEvent : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("EventTabbar")
        self.presentViewController(showEvent, animated: true, completion: nil)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }
   
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.endEditing(true)
       
        return true
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return RepeatEvent.count
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        repeatTextField.text = RepeatEvent[row]
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return RepeatEvent[row]
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let showEvent : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("EventCollection")
        self.presentViewController(showEvent, animated: true, completion: nil)
    }
    
}

