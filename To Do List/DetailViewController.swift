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

    @IBOutlet weak var theSwitch: UISwitch!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    // Display the image and label
    var imageDetail = UIImage()
    var descriptionDetail = ""
    // text to speech 
    
    
    var rate: Float!
    
    //var pitch: Float!
    //var volume: Float!
    
    //text to spech
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
       
    @IBAction func switchcontroll(sender: AnyObject) {
        let photo = detailImage.image
        let todoItemCreated = ToDoItem(imageName: photo, description: detailLabel.text!)
        if theSwitch.on
        {
            finishList.append(todoItemCreated)
            let index = toDoList.indexOf({ $0.imageName == photo })
            print(index)
            toDoList.removeAtIndex(index!)
        }
        else
        {
            toDoList.append(todoItemCreated)
            let index = finishList.indexOf({ $0.imageName == photo })
            finishList.removeAtIndex(index!)
        }
    }
    
    @IBAction func onOffSwitch(sender: AnyObject) {
        let photo = detailImage.image
        let todoItemCreated = ToDoItem(imageName: photo, description: detailLabel.text!)
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
        myUtterance = AVSpeechUtterance(string: detailLabel.text!)
        let voice = AVSpeechSynthesisVoice(language: "en-AU")
        myUtterance.voice = voice
        myUtterance.rate = rate
        print(rate)
       // myUtterance.pitchMultiplier = 0.3
       // myUtterance.volume = 0.3
        synth.speakUtterance(myUtterance)
    }
  
    @IBAction func textToSpeechMaleVoice(sender: AnyObject) {
        myUtterance = AVSpeechUtterance(string: detailLabel.text!)
        let voice = AVSpeechSynthesisVoice(language: "en-GB")
        myUtterance.voice = voice
        let voices = AVSpeechSynthesisVoice.speechVoices()
        print(voices)
        
        myUtterance.rate = rate
        //myUtterance.pitchMultiplier = 0.3
        //myUtterance.volume = 0.3
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailImage.image = imageDetail
        detailLabel.text = descriptionDetail
        
        
        
        if toDoList.contains({ $0.imageName == imageDetail })
        {
            self.theSwitch.on = false
        }
        else
        {
            self.theSwitch.on = true
        }
        if !loadSetting(){
            registerDefaultVoiceSetting()
        }
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

