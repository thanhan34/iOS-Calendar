//
//  DetailViewController.swift
//  To Do List
//
//  Created by Doan Thanh An on 1/08/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController, AVSpeechSynthesizerDelegate, UIPopoverPresentationControllerDelegate, PopOverSettingViewControllerDelegate {

    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var theSwitch: UISwitch!
    
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
    // text to speech 
    
    
    var rate: Float!
    //var voice: AVSpeechSynthesisVoice!
    var currentLanguageCode: String!
    var stringToSpeech: String!
    
    
    //var pitch: Float!
    //var volume: Float!
    
    //text to spech
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        titleLabel.text = titleEvent
        staffLabel.text = staffEvent
        detailImage.image = imageDetail
        locationLabel.text = locationEvent
        startLabel.text = startEvent
        print(startEvent)
        endLabel.text = endEvent
        repeatLabel.text = repeatEvent
        secondPhoto.image = secondPhotoEvent
        detailLabel.text = descriptionDetail
        
       // stringToSpeech = titleEvent + staffEvent + locationEvent + startEvent + endEvent + repeatEvent + descriptionDetail
        
        stringToSpeech = "You have a \(titleEvent) with \(staffEvent) at \(locationEvent) from \(startEvent) to \(endEvent) It will repeat \(repeatEvent) time. Detail about the event would be \(descriptionDetail) "
        
        if toDoList.contains({ $0.imageName == imageDetail })
        {
            self.theSwitch.on = false
        }
        else
        {
            self.theSwitch.on = true
        }
        
        if toDoList.contains({ $0.imageName == imageDetail}) {
            self.checkBox.isChecked = false
        } else {
            self.checkBox.isChecked = true
        }
        
        
        
        
        if !loadSetting(){
            registerDefaultVoiceSetting()
        }
    }
    
       
    @IBAction func checkBox(sender: AnyObject) {
        let photo = detailImage.image
        let secondimage = secondPhoto.image
        let todoItemCreated = ToDoItem(title: titleLabel.text!, staff: staffLabel.text!, location: locationLabel.text!, starts: startLabel.text!, ends: endLabel.text!, rpeat: repeatLabel.text!, imageName: photo, description: detailLabel.text!, secondPhoto: secondimage)
        //   let todoItemCreated = ToDoItem(imageName: photo, description: detailLabel.text!)
        print(todoItemCreated.description)
        if checkBox.isChecked == false {
            finishList.append(todoItemCreated)
            let index = toDoList.indexOf({ $0.imageName == photo })
            toDoList.removeAtIndex(index!)
        } else {
            toDoList.append(todoItemCreated)
            let index = finishList.indexOf({ $0.imageName == photo })
            finishList.removeAtIndex(index!)
        }
        
    }
    
    
    
    @IBAction func onOffSwitch(sender: AnyObject) {
        let photo = detailImage.image
        let secondimage = secondPhoto.image
        let todoItemCreated = ToDoItem(title: titleLabel.text!, staff: staffLabel.text!, location: locationLabel.text!, starts: startLabel.text!, ends: endLabel.text!, rpeat: repeatLabel.text!, imageName: photo, description: detailLabel.text!, secondPhoto: secondimage)
     //   let todoItemCreated = ToDoItem(imageName: photo, description: detailLabel.text!)
        print(todoItemCreated.description)
        if theSwitch.on
        {
            finishList.append(todoItemCreated)
            let index = toDoList.indexOf({ $0.imageName == photo })
            toDoList.removeAtIndex(index!)
        }
        else
        {
            toDoList.append(todoItemCreated)
            let index = finishList.indexOf({ $0.imageName == photo })
            finishList.removeAtIndex(index!)
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
      //  print(currentLanguageCode)
        myUtterance.voice = voice
        myUtterance.rate = rate
        print(rate)
       // myUtterance.pitchMultiplier = 0.3
       // myUtterance.volume = 0.3
        synth.speakUtterance(myUtterance)
    }
  
    
  
    func loadSetting() -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults() as NSUserDefaults
        if let theRate: Float = userDefaults.valueForKey("rate") as? Float {
            rate = theRate
            print(rate)
           // pitch = userDefaults.valueForKey("pitch") as! Float
           // volume = userDefaults.valueForKey("volume") as! Float
            return true
            
        }
        return false
    }
    
   
    
    //popover
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showPopover"
        {
            let popoverViewController = segue.destinationViewController
            popoverViewController.popoverPresentationController?.delegate = self
            let settingsViewController = segue.destinationViewController as! PopOverSettingViewController
            settingsViewController.delegate = self
        }
        
        
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.None
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
        //print(currentLanguageCode)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

