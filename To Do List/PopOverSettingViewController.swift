//
//  PopOverSettingViewController.swift
//  To Do List
//
//  Created by Doan Thanh An on 21/08/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import AVFoundation

protocol PopOverSettingViewControllerDelegate: class {
    func didSaveSettings()
}

class PopOverSettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var MaleFemalePicer: UIPickerView!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var Slider: UISlider!
    
    var delegate: PopOverSettingViewControllerDelegate!
    
    var speechSettings = NSUserDefaults.standardUserDefaults()
    var rate: Float!
    let valuekey = "rate"
   // var voice = AVSpeechSynthesisVoice.init(language: "")
    var currentLanguageCode: String!
    
    var Array = ["Male","Female"]
    var PlacementAnswer = 0
    
    var languageload: String!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        Slider.value = speechSettings.floatForKey(valuekey)
        valueLabel.text = "\(Slider.value)"
        
        MaleFemalePicer.delegate = self
        MaleFemalePicer.dataSource = self
        
        // Load the value of view picker
        languageload = speechSettings.stringForKey("code")
        if (languageload == nil) || (languageload == "en-GB") {
            languageload = "en-GB"
            self.MaleFemalePicer.selectRow(0, inComponent: 0, animated: true)
        } else
        if languageload == "en-AU" {
            self.MaleFemalePicer.selectRow(1, inComponent: 0, animated: true)
        }
        //else if languageload == "en-GB" {
          //  self.MaleFemalePicer.selectRow(0, inComponent: 0, animated: true)
        
        //}
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RateSlider(sender: AnyObject) {
        valueLabel.text = "\(Slider.value)"
        rate = Slider.value
        //NSUserDefaults.standardUserDefaults().valueForKey("rate")
        //NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func saveSettings(sender: AnyObject) {
        
        if (PlacementAnswer == 0){
            currentLanguageCode = "en-GB"
            //print(currentLanguageCode)
            //NSUserDefaults.standardUserDefaults().stringForKey(currentLanguageCode)
        } else
        {
            currentLanguageCode = "en-AU"
            
            //  NSUserDefaults.standardUserDefaults().stringForKey(currentLanguageCode)
            
            //let voice = AVSpeechSynthesisVoice(language: "en-GB")
            //NSUserDefaults.standardUserDefaults().objectForKey("voice")
        }
        
        NSUserDefaults.standardUserDefaults().setObject(currentLanguageCode, forKey: "code")
        NSUserDefaults.standardUserDefaults().synchronize()
        delegate.didSaveSettings()
        rate = Slider.value
        NSUserDefaults.standardUserDefaults().setFloat(rate, forKey: valuekey)
        NSUserDefaults.standardUserDefaults().synchronize()
            delegate.didSaveSettings()
       // }
    
        navigationController?.popToRootViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Array.count
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        PlacementAnswer = row
        
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let desViewController = segue.destinationViewController as! DetailViewController
        desViewController.delegate = self
       // voicerateSettingController.rate = self.Slider.value
        
        
        
        //voicerateSettingController.delegate = self
        
    }*/
    /*func didSaveSetting(){
        let settings = NSUserDefaults.standardUserDefaults() as NSUserDefaults!
        rate = settings.valueForKey("rate") as! Float
        
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
