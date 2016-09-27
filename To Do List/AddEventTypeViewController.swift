//
//  AddEventTypeViewController.swift
//  To Do List
//
//  Created by Doan Thanh An on 25/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AddEventTypeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var EventImage: UIImageView!
    
    @IBOutlet weak var EventTitle: UITextField!
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    var storageRef: FIRStorageReference! {
        return FIRStorage.storage().reference()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [NSObject : AnyObject]?) {
        print("Image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        
            EventImage.image = image
        
    }
    
    
    
    
    @IBAction func BackAction(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func UploadImageAction(sender: AnyObject) {
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
    }
    
    @IBAction func AddEventTypeAction(sender: AnyObject){
        let data = UIImageJPEGRepresentation(self.EventImage.image!, 0.4)
        
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let eventtypeID = "\(NSUUID().UUIDString)"
        let imagePath = "postImages/\(eventtypeID)/postPic1.jpg"
        
        storageRef.child(imagePath).putData(data!, metadata: metadata)
        { (metadata, error) in
            if error == nil
            {
                let eventRef = self.databaseRef.child("eventype").childByAutoId()
                
                let eventType = AddEventType(eventImage: String(metadata!.downloadURL()!), eventName: self.EventTitle.text!)
                eventRef.setValue(eventType.toAnyObject())
                              
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
        EventTitle.resignFirstResponder()
        return true
    }
}


