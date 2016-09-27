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
    @IBOutlet weak var FontSizePicker: UIPickerView!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var Slider: UISlider!
    
    var delegate: PopOverSettingViewControllerDelegate!
    
    var speechSettings = NSUserDefaults.standardUserDefaults()
    var rate: Float!
    let valuekey = "rate"
    var currentLanguageCode: String!
    var fontsettingvalue: Float!
    var FontSize = ["Large","Medium","Small"]
    var Array = ["Male","Female"]
    var PlacementAnswer = 0
    var FontSizeValue = 0
    
    var languageload: String!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        Slider.value = speechSettings.floatForKey(valuekey)
        valueLabel.text = "\(Slider.value)"
        
        MaleFemalePicer.delegate = self
        MaleFemalePicer.dataSource = self
        
        FontSizePicker.delegate = self
        FontSizePicker.dataSource = self
        
        // Load the value of view picker
        languageload = speechSettings.stringForKey("code")
        if (languageload == nil) || (languageload == "en-GB") {
            languageload = "en-GB"
            self.MaleFemalePicer.selectRow(0, inComponent: 0, animated: true)
        } else
        if languageload == "en-AU" {
            self.MaleFemalePicer.selectRow(1, inComponent: 0, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RateSlider(sender: AnyObject) {
        valueLabel.text = "\(Slider.value)"
        rate = Slider.value
    }
    
    @IBAction func saveSettings(sender: AnyObject) {
        
        if (PlacementAnswer == 0){
            currentLanguageCode = "en-GB"
        } else
        {
            currentLanguageCode = "en-AU"
        }
        
        if (FontSizeValue == 0) {
            fontsettingvalue = 30
        }
        else if (FontSizeValue == 1) {
            fontsettingvalue = 25
        }
        else {
            fontsettingvalue = 20
        }
        NSUserDefaults.standardUserDefaults().setFloat(fontsettingvalue, forKey: "fontsize")
        NSUserDefaults.standardUserDefaults().synchronize()
        
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
        if (pickerView.tag == 1) {
        
        
        return Array[row]
        }
        else {
        return FontSize[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return Array.count
        }
        else {
            return FontSize.count
        }
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView.tag == 1){
            PlacementAnswer = row
        } else {
            FontSizeValue = row
        }
        
    }
    
    
    

}
