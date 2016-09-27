//
//  ThirdViewController.swift
//  To Do List
//
//  Created by Doan Thanh An on 12/08/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

var finishList:[TodoItemDatabase] = [TodoItemDatabase]()


class CompletedEventViewController: UIViewController, UITableViewDelegate {
    
    var rate: Float!
    var currentLanguageCode = NSUserDefaults.standardUserDefaults().stringForKey("code")
    var stringToSpeech: String!
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    var databaseRef: FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    
    }
    
    var storageRef: FIRStorageReference!
    
    @IBOutlet weak var finishListTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !loadSetting(){
            registerDefaultVoiceSetting()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finishList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myFinishCell", forIndexPath: indexPath) as! myFinishCell
        let finishtodoItem = finishList[indexPath.row]
        cell.myFinishLabel.text = finishtodoItem.title
        if let mainImageUrl = finishtodoItem.imageName {
            cell.myFinishImageView.loadImageUsingCacheWithUrlString(mainImageUrl)
            cell.myFinishImageView.contentMode = .ScaleAspectFit
            cell.myFinishImageView.clipsToBounds = true
        }
        cell.checkbox.isChecked = true
        cell.checkbox.addTarget(self, action: #selector(CompletedEventViewController.checkBox(_:)), forControlEvents: .TouchUpInside)
        cell.speaker.addTarget(self, action: #selector(CompletedEventViewController.textToSpeech(_:)), forControlEvents: .TouchUpInside)
        return cell
    }
    
    func registerDefaultVoiceSetting(){
        rate = AVSpeechUtteranceDefaultSpeechRate
        let defaultSpeechSetting: NSDictionary = ["rate": rate]
        NSUserDefaults.standardUserDefaults().registerDefaults(defaultSpeechSetting as! [String : AnyObject])
    }
    
    func loadSetting() -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults() as NSUserDefaults
        if let theRate: Float = userDefaults.valueForKey("rate") as? Float {
            rate = theRate
            return true
        }
        return false
    }
    
    @IBAction func textToSpeech(sender: AnyObject){
        let buttonPosition = sender.convertPoint(CGPointZero, toView: self.finishListTable)
        let indexPath = self.finishListTable.indexPathForRowAtPoint(buttonPosition)
        if indexPath != nil {
            let itemSelected = finishList[indexPath!.row]
            let speechStringBuilder: [String: String] = [
                "title" : itemSelected.title,
                "staff" : itemSelected.staff,
                "location" : itemSelected.location,
                "start" : itemSelected.starts,
                "end" : itemSelected.ends,
                "repeat" : itemSelected.rpeat,
                "description" : itemSelected.description
            ]
            
            if let titleString = speechStringBuilder["title"] {
                if titleString != "" {
                    stringToSpeech = "You have a \(titleString) "
                }
                else {
                    stringToSpeech = " "
                }
            }
            if let staffString = speechStringBuilder["staff"] {
                if staffString != "" {
                    stringToSpeech = stringToSpeech + "with \(staffString) "
                }
                else {
                    stringToSpeech = stringToSpeech + " "
                }
            }
            if let locationString = speechStringBuilder["location"] {
                if locationString != "" {
                    stringToSpeech = stringToSpeech + "at \(locationString)"
                }
                else {
                    stringToSpeech = stringToSpeech + " "
                }
            }
            if let startString = speechStringBuilder["start"] {
                if startString != "" {
                    stringToSpeech = stringToSpeech + "from \(startString) "
                }
                else {
                    stringToSpeech = stringToSpeech + " "
                }
            }
            if let endString = speechStringBuilder["end"] {
                if endString != "" {
                    stringToSpeech = stringToSpeech + "to \(endString) "
                }
                else {
                    stringToSpeech = stringToSpeech + " "
                }
            }
            if let repeatString = speechStringBuilder["repeat"] {
                if repeatString != "" {
                    stringToSpeech = stringToSpeech + "It would be \(repeatString) time."
                }
                else {
                    stringToSpeech = stringToSpeech + " "
                }
            }
            if let descriptionString = speechStringBuilder["description"] {
                if descriptionString != "" {
                    stringToSpeech = stringToSpeech + "Detail about the event would be \(descriptionString)."
                }
                else {
                    stringToSpeech = stringToSpeech + " "
                }
            }
            myUtterance = AVSpeechUtterance(string: stringToSpeech)
            let voice = AVSpeechSynthesisVoice(language: currentLanguageCode)
            print(currentLanguageCode)
            myUtterance.voice = voice
            myUtterance.rate = rate
            synth.speakUtterance(myUtterance)
        }
    }
    
    @IBAction func checkBox(sender: CheckBox){
        let isCompleted = false
        let buttonPosition = sender.convertPoint(CGPointZero, toView: self.finishListTable)
        let indexPath = self.finishListTable.indexPathForRowAtPoint(buttonPosition)
        if indexPath != nil {
            let itemSelected = finishList[indexPath!.row]
            let updateRef = self.databaseRef!.child("posts/\(itemSelected.key)")
            let updateevent = TodoItemDatabase(
                username: FIRAuth.auth()!.currentUser!.displayName!,
                eventID: itemSelected.eventID,
                title: itemSelected.title,
                staff: itemSelected.staff,
                location: itemSelected.location,
                starts: itemSelected.starts,
                ends: itemSelected.ends,
                rpeat: itemSelected.rpeat,
                imageName: itemSelected.imageName,
                description: itemSelected.description,
                secondPhoto: itemSelected.secondPhoto,
                isCompleted: isCompleted)
            
            updateRef.updateChildValues(updateevent.toAnyObject())
            
        }
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            let ref = finishList[indexPath.row]
            ref.ref?.removeValue()
            finishList.removeAtIndex(indexPath.row)
            finishListTable.reloadData()
        }
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        finishListTable.reloadData()
        
    }
    override func viewWillAppear(animated: Bool) {
        let postRef = FIRDatabase.database().reference().child("posts").queryOrderedByChild("username").queryEqualToValue(FIRAuth.auth()!.currentUser!.displayName!)
        
        
        postRef.observeEventType(.Value, withBlock: { (snapshot) in
            var newPosts = [TodoItemDatabase]()
            for post in snapshot.children{
                let post = TodoItemDatabase(snapshot: post as! FIRDataSnapshot)
                if post.isCompleted == true {
                newPosts.insert(post, atIndex: 0)
                }
            }
            finishList = newPosts
            dispatch_async(dispatch_get_main_queue(), {
                self.finishListTable.reloadData()
            })
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        storageRef = FIRStorage.storage().referenceForURL(finishList[indexPath.row].imageName)
        let storageRef1 = FIRStorage.storage().referenceForURL(finishList[indexPath.row].secondPhoto)
        let itemSelected = finishList[indexPath.row]
        storageRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) in
            if error == nil
            {
                dispatch_async(dispatch_get_main_queue(), {
                    if let data = data
                    {
                        storageRef1.dataWithMaxSize(1 * 1024 * 1024) { (data1, error) in
                            
                            if error == nil
                            {
                                dispatch_async(dispatch_get_main_queue(), {
                                    if let data1 = data1
                                    {
                                        let detailVC:DetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
                                        detailVC.eventIDfromDetail = itemSelected.eventID
                                        detailVC.titleEvent = itemSelected.title
                                        detailVC.staffEvent = itemSelected.staff
                                        detailVC.locationEvent = itemSelected.location
                                        detailVC.startEvent = itemSelected.starts
                                        detailVC.endEvent = itemSelected.ends
                                        detailVC.repeatEvent = itemSelected.rpeat
                                        detailVC.imageDetail = UIImage(data: data)!
                                        detailVC.descriptionDetail = itemSelected.description
                                        detailVC.secondPhotoEvent = UIImage(data: data1)!
                                        detailVC.key = itemSelected.key
                                        detailVC.isFinishFromDetail = itemSelected.isCompleted
                                        
                                        self.presentViewController(detailVC, animated: true, completion: nil)
                                    }
                                })
                            }
                            else
                            {
                                print(error!.localizedDescription)
                            }
                            
                        }}
                })
            }
            else
            {
                print(error!.localizedDescription)
            }
            
        }
    }

    
    @IBAction func backHomeAction(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let backHome : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MainScreen")
        self.presentViewController(backHome, animated: true, completion: nil)
    }
    
}