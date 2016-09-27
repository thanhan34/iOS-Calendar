//
//  MainScreenViewController.swift
//  To Do List
//
//  Created by Doan Thanh An on 5/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class MainScreenViewController: UIViewController, UIPopoverPresentationControllerDelegate, PopOverSettingViewControllerDelegate {

    @IBOutlet weak var userImageView: CustomizableImageView!
    
    @IBOutlet weak var userName: UILabel!
    var rate: Float!
    //var voice: AVSpeechSynthesisVoice!
    var currentLanguageCode: String!
    var stringToSpeech: String!
    var databaseRef: FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
    var storageRef: FIRStorage!{
        return FIRStorage.storage()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if FIRAuth.auth()?.currentUser == nil {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            presentViewController(vc, animated: true, completion: nil)
        }
        else {
            databaseRef.child("users/\(FIRAuth.auth()!.currentUser!.uid)").observeEventType(.Value, withBlock: { (snapshot) in
                dispatch_async(dispatch_get_main_queue(), {
                    let user = User(snapshot: snapshot)
                    self.userName.text = user.username
                    
                    
                    let imageUrl = String(user.photoUrl)
                    self.storageRef.referenceForURL(imageUrl).dataWithMaxSize(1 * 1024 * 1024, completion: { (data, error) in
                        if let error = error {
                            print (error.localizedDescription)
                        } else {
                            if let data = data {
                                self.userImageView.image = UIImage(data: data)
                                self.userImageView.contentMode = .ScaleAspectFill
                                self.userImageView.layer.borderWidth = 5
                                self.userImageView.layer.borderColor = UIColor(red: 222/255.0, green: 255/255.0, blue: 227/255.0, alpha: 1.0).CGColor
                            }
                        }
                        
                    })
                    
                })
                
                
                
            }) { (error) in
                print(error.localizedDescription)
            
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutAction(sender: AnyObject) {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                    presentViewController(vc, animated: true, completion: nil)
            }
            catch let error as NSError {
                    print(error.localizedDescription)
            }
        }
    }
   
    @IBAction func eventShowAction(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let showEvent : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("EventTabbar")
        self.presentViewController(showEvent, animated: true, completion: nil)
    }
    
    func didSaveSettings() {
        let settings = NSUserDefaults.standardUserDefaults() as NSUserDefaults!
        rate = settings.floatForKey("rate")
        
        let voiceSetting = NSUserDefaults.standardUserDefaults() as NSUserDefaults!
        
        currentLanguageCode = voiceSetting.stringForKey("code")
        
    }
    
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

    

}
