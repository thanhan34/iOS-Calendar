//
//  DetailViewController.swift
//  To Do List
//
//  Created by Doan Thanh An on 1/08/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseStorage
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DetailViewController: UIViewController, AVSpeechSynthesizerDelegate {

    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var staffLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var secondPhoto: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    // Display the image and label
    var titleEvent = ""
    var staffEvent = ""
    var imageDetail = UIImage()
    var locationEvent = ""
    var startEvent = ""
    var endEvent = ""
    var repeatEvent = ""
    var secondPhotoEvent = UIImage()
    var descriptionDetail = ""
    var key = ""
    var isFinishFromDetail: Bool = false
    var eventIDfromDetail = ""
    // text to speech 
    
    
    var rate: Float!
    
    var fontsize = NSUserDefaults.standardUserDefaults().floatForKey("fontsize")
    var currentLanguageCode = NSUserDefaults.standardUserDefaults().stringForKey("code")
    var stringToSpeech: String!
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    var storageRef: FIRStorageReference! {
        return FIRStorage.storage().reference()
    }
    
    
    
    //text to spech
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(fontsize)
        let cgfloatfontsize = CGFloat(fontsize)
        // Do any additional setup after loading the view.
        
        titleLabel.text = titleEvent
        titleLabel.font = titleLabel.font.fontWithSize(cgfloatfontsize)
        titleLabel.sizeToFit()
        //titleLabel.textColor = UIColor.whiteColor()
        
        staffLabel.text = staffEvent
        staffLabel.font = staffLabel.font.fontWithSize(cgfloatfontsize)
        staffLabel.sizeToFit()
        //staffLabel.textColor = UIColor.whiteColor()
        
        detailImage.image = imageDetail
        
        
        locationLabel.text = locationEvent
        locationLabel.font = locationLabel.font.fontWithSize(cgfloatfontsize)
        locationLabel.sizeToFit()
        //locationLabel.textColor = UIColor.whiteColor()
        
        startLabel.text = startEvent
        startLabel.font = startLabel.font.fontWithSize(cgfloatfontsize)
        startLabel.sizeToFit()
        //startLabel.textColor = UIColor.whiteColor()
        
        endLabel.text = endEvent
        endLabel.font = endLabel.font.fontWithSize(cgfloatfontsize)
        endLabel.sizeToFit()
        //endLabel.textColor = UIColor.whiteColor()
        
        repeatLabel.text = repeatEvent
        repeatLabel.font = repeatLabel.font.fontWithSize(cgfloatfontsize)
        repeatLabel.sizeToFit()
        //repeatLabel.textColor = UIColor.whiteColor()
        
        secondPhoto.image = secondPhotoEvent
        
        detailLabel.text = descriptionDetail
        detailLabel.font = detailLabel.font.fontWithSize(cgfloatfontsize)
        detailLabel.sizeToFit()
        //detailLabel.textColor = UIColor.whiteColor()
        
        checkBox.isChecked = isFinishFromDetail
      
        
        
        let speechStringBuilder: [String: String] = [
            "title" : titleEvent,
            "staff" : staffEvent,
            "location" : locationEvent,
            "start" : startEvent,
            "end" : endEvent,
            "repeat" : repeatEvent,
            "description" : descriptionDetail
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
       
        if !loadSetting(){
            registerDefaultVoiceSetting()
        }
    }
    
    @IBAction func checkBox(sender: AnyObject) {
        let data = UIImageJPEGRepresentation(self.imageDetail, 0.4)
        let data1 = UIImageJPEGRepresentation(self.secondPhotoEvent, 0.4)
        
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let metadata1 = FIRStorageMetadata()
        metadata1.contentType = "image/jpeg"
       
        let imagePath = "postImages/\(eventIDfromDetail)/postPic1.jpg"
        let imagePath1 = "postImages/\(eventIDfromDetail)/postPic2.jpg"
        var isCompleted: Bool = false
        
        
        if checkBox.isChecked == false {
            isCompleted = true
            storageRef.child(imagePath).putData(data!, metadata: metadata)
            { (metadata, error) in
                if error == nil
                {
                    self.storageRef.child(imagePath1).putData(data1!, metadata: metadata1)
                    { (metadata1, error1) in
                        if error1 == nil
                        {
                            let updateRef = self.databaseRef.child("/posts/\(self.key)")
                            let updateevent = TodoItemDatabase(username: FIRAuth.auth()!.currentUser!.displayName!,
                                                               eventID: self.eventIDfromDetail,
                                                               title: self.titleEvent,
                                                               staff: self.staffEvent,
                                                               location: self.locationEvent,
                                                               starts: self.startEvent,
                                                               ends: self.endEvent,
                                                               rpeat: self.repeatEvent,
                                                               imageName: String(metadata!.downloadURL()!),
                                                               description: self.descriptionDetail,
                                                               secondPhoto: String(metadata1!.downloadURL()!),
                                                               isCompleted: isCompleted)
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
        }
            else {
            isCompleted = false
            storageRef.child(imagePath).putData(data!, metadata: metadata)
            { (metadata, error) in
                if error == nil
                {
                    self.storageRef.child(imagePath1).putData(data1!, metadata: metadata1)
                    { (metadata1, error1) in
                        if error1 == nil
                        {
                            let updateRef = self.databaseRef.child("/posts/\(self.key)")
                            let updateevent = TodoItemDatabase(username: FIRAuth.auth()!.currentUser!.displayName!,
                                                               eventID: self.eventIDfromDetail,
                                                               title: self.titleEvent,
                                                               staff: self.staffEvent,
                                                               location: self.locationEvent,
                                                               starts: self.startEvent,
                                                               ends: self.endEvent,
                                                               rpeat: self.repeatEvent,
                                                               imageName: String(metadata!.downloadURL()!),
                                                               description: self.descriptionDetail,
                                                               secondPhoto: String(metadata1!.downloadURL()!),
                                                               isCompleted: isCompleted)
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
            
        }
       
        
        
    }
    
 
    func registerDefaultVoiceSetting(){
        
        rate = AVSpeechUtteranceDefaultSpeechRate
        let defaultSpeechSetting: NSDictionary = ["rate": rate]
        NSUserDefaults.standardUserDefaults().registerDefaults(defaultSpeechSetting as! [String : AnyObject])
    }
    
 
    @IBAction func textToSpech(sender: AnyObject) {
        myUtterance = AVSpeechUtterance(string: stringToSpeech)
        let voice = AVSpeechSynthesisVoice(language: currentLanguageCode)
        myUtterance.voice = voice
        myUtterance.rate = rate
        synth.speakUtterance(myUtterance)
    }
  
  
    func loadSetting() -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults() as NSUserDefaults
        if let theRate: Float = userDefaults.valueForKey("rate") as? Float {
            rate = theRate
           // pitch = userDefaults.valueForKey("pitch") as! Float
           // volume = userDefaults.valueForKey("volume") as! Float
            return true
        }
        return false
    }
    
   
    
    //popover
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "updateEvent"
        {
            let svc: UpdateEventViewController = segue.destinationViewController as! UpdateEventViewController
            svc.updatetitleEvent = titleLabel.text!
            svc.updatestaffEvent = staffLabel.text!
            svc.updateimageDetail = detailImage.image!
            svc.updatelocationEvent = locationLabel.text!
            svc.updatestartEvent = startLabel.text!
            svc.updateendEvent = endLabel.text!
            svc.updaterepeatEvent = repeatLabel.text!
            svc.updatesecondPhotoEvent = secondPhoto.image!
            svc.updatedescriptionDetail = detailLabel.text!
            svc.updatekeyEvent = key
            svc.isFinishFromUpdate = isFinishFromDetail
            svc.updateEventID = eventIDfromDetail
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func didSaveSettings() {
        let settings = NSUserDefaults.standardUserDefaults() as NSUserDefaults!
        rate = settings.floatForKey("rate")
        let voiceSetting = NSUserDefaults.standardUserDefaults() as NSUserDefaults!
        currentLanguageCode = voiceSetting.stringForKey("code")
       
    }
   
}

