//
//  UpdateEventViewController.swift
//  To Do List
//
//  Created by Doan Thanh An on 8/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase
import FirebaseAuth
import FirebaseDatabase

class UpdateEventViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var updateTitleTextField: UITextField!
    @IBOutlet weak var updateStaffTextField: UITextField!
    @IBOutlet weak var updateLocationTextField: UITextField!
    @IBOutlet weak var updateStartDate: UITextField!
    @IBOutlet weak var updateEndDate: UITextField!
    @IBOutlet weak var updateRepeatTextField: UITextField!
    @IBOutlet weak var updateImportedImage: UIImageView!
    @IBOutlet weak var updateSecondPhoto: UIImageView!
    @IBOutlet var updateitem: UITextField!
    
    var updatetitleEvent = ""
    var updatestaffEvent = ""
    var updateimageDetail = UIImage()
    var updatelocationEvent = ""
    var updatestartEvent = ""
    var updateendEvent = ""
    var updaterepeatEvent = ""
    var updatesecondPhotoEvent = UIImage()
    var updatedescriptionDetail = ""
    var updatekeyEvent = ""
    var updateEventID = ""
    

    
    
    
    var isFinishFromUpdate: Bool = false
    
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
        self.updateTitleTextField.delegate = self
        self.updateStaffTextField.delegate = self
        self.updateLocationTextField.delegate = self
        
        
        self.updateitem.delegate = self
        self.updateStartDate.delegate = self
        self.updateEndDate.delegate = self
        
        updateTitleTextField.text = updatetitleEvent
        updateStaffTextField.text = updatestaffEvent
        updateLocationTextField.text = updatelocationEvent
        updateStartDate.text = updatestartEvent
        updateEndDate.text = updateendEvent
        updateRepeatTextField.text = updaterepeatEvent
        updateImportedImage.image = updateimageDetail
        updateImportedImage.clipsToBounds = true
        updateImportedImage.contentMode = .ScaleAspectFit
        updateSecondPhoto.image = updatesecondPhotoEvent
        updateSecondPhoto.contentMode = .ScaleAspectFit
        updateSecondPhoto.clipsToBounds = true
        updateitem.text = updatedescriptionDetail
        
        picker.delegate = self
        picker.dataSource = self
        updateRepeatTextField.inputView = picker
        
        ScrollView.contentSize.height = 600
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddEventViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        ScrollView.addGestureRecognizer(tapGesture)
        
        print(isFinishFromUpdate)
        
        
    }
    func hideKeyboard(){
        updateTitleTextField.resignFirstResponder()
        updateStaffTextField.resignFirstResponder()
        updateLocationTextField.resignFirstResponder()
        updateStartDate.resignFirstResponder()
        updateEndDate.resignFirstResponder()
        updateRepeatTextField.resignFirstResponder()
        updateitem.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        
        let datePicker = UIDatePicker()
        updateStartDate.inputView = datePicker
        updateEndDate.inputView = datePicker
        //textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(AddEventViewController.datePickerChanged(_:)), forControlEvents: .ValueChanged)
        
        if (textField == updateitem) {
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
        if ( updateStartDate.editing){
            updateStartDate.text = formatter.stringFromDate(sender.date)
        }
        if (updateEndDate.editing){
            updateEndDate.text = formatter.stringFromDate(sender.date)
        }
        
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [NSObject : AnyObject]?) {
        print("Image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        updateSecondPhoto.image = image

    }
    
    // MARK: - Action Sheet
    
    
   
    
    @IBAction func showActionSheet2(sender: AnyObject) {
        
        let image1 = UIImagePickerController()
        image1.delegate = self
        
        let actionSheet = UIAlertController(title: "Action Sheet", message: "Choose Option", preferredStyle: .Alert)
        let libButton = UIAlertAction(title: "Select from photo library", style: .Default, handler: { (libButton) -> Void in
            image1.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            image1.allowsEditing = false
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
    
    
    
    @IBAction func updateEvent(sender: AnyObject) {
        let data = UIImageJPEGRepresentation(self.updateImportedImage.image!, 0.5)
        let data1 = UIImageJPEGRepresentation(self.updateSecondPhoto.image!, 0.5)
        
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let metadata1 = FIRStorageMetadata()
        metadata1.contentType = "image/jpeg"
        
        let imagePath = "postImages/postPic1.jpg"
        let imagePath1 = "postImages/postPic2.jpg"
        
        
        storageRef.child(imagePath).putData(data!, metadata: metadata)
        { (metadata, error) in
            if error == nil
            {
                self.storageRef.child(imagePath1).putData(data1!, metadata: metadata1)
                { (metadata1, error1) in
                    if error1 == nil
                    {
                        let updateRef = self.databaseRef.child("/posts/\(self.updatekeyEvent)")
                        let updateevent = TodoItemDatabase(username: FIRAuth.auth()!.currentUser!.displayName!,
                                                     eventID: self.updateEventID,
                                                     title: self.updateTitleTextField.text!,
                                                     staff: self.updateStaffTextField.text!,
                                                     location: self.updateLocationTextField.text!,
                                                     starts: self.updateStartDate.text!,
                                                     ends: self.updateStartDate.text!,
                                                     rpeat: self.updateRepeatTextField.text!,
                                                     imageName: String(metadata!.downloadURL()!),
                                                     description: self.updateitem.text!,
                                                     secondPhoto: String(metadata1!.downloadURL()!),
                                                     isCompleted: self.isFinishFromUpdate)
                        updateRef.updateChildValues(updateevent.toAnyObject())
                        
                        
                        
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
        
        
        
        navigationController?.popToRootViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        
    }
    
    
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return RepeatEvent.count
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateRepeatTextField.text = RepeatEvent[row]
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return RepeatEvent[row]
    }

    @IBAction func cancelButton(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
