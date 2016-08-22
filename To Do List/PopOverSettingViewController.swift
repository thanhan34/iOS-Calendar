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

class PopOverSettingViewController: UIViewController {
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var Slider: UISlider!
    
    var delegate: PopOverSettingViewControllerDelegate!
    
    var speechSettings = NSUserDefaults.standardUserDefaults()
    var rate: Float!
    let valuekey = "rate"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Slider.value = speechSettings.floatForKey(valuekey)
        
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
        //rate = Slider.value
        NSUserDefaults.standardUserDefaults().setFloat(rate, forKey: valuekey)
        NSUserDefaults.standardUserDefaults().synchronize()
            delegate.didSaveSettings()
       // }
    
        navigationController?.popToRootViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
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
