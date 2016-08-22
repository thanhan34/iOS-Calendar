//
//  SecondViewController.swift
//  To Do List
//
//  Created by Rob Percival on 16/01/2015.
//  Copyright (c) 2015 Appfish. All rights reserved.
//

import UIKit


class SecondViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var importedImage: UIImageView!
    
    @IBOutlet var item: UITextField!
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [NSObject : AnyObject]?) {
        
        print("Image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        importedImage.image = image
        
    }
    @IBAction func importImage(sender: AnyObject) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    @IBAction func cameraButton(sender: AnyObject) {
        let image = UIImagePickerController()
        image.sourceType = .Camera
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    @IBAction func addEvent(sender: AnyObject) {
        let photo = importedImage.image
        
        let todoItemCreated = ToDoItem(imageName: photo, description: item.text!)
        print(todoItemCreated)
        toDoList.append(todoItemCreated)
        print("finish added")
        
        item.text = ""
        importedImage.image = UIImage(named: "images.jpg")
        // NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")
        //NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "arraytodolist")
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.item.delegate = self
        importedImage.image = UIImage(named: "images.jpg")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        item.resignFirstResponder()
        return true
        
    }
    

}

