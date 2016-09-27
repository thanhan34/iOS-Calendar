
//
//  AddEventCollectionViewController.swift
//  To Do List
//
//  Created by Doan Thanh An on 25/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AddEventCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var eventTypeCollectionView: UICollectionView!
    var eventType:[AddEventType] = [AddEventType]()
    
    var databaseRef: FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(eventType)
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventType.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellcollection", forIndexPath: indexPath) as! EventTypeCollectionViewCell
        let eventitem = eventType[indexPath.row]
        cell.eventTitle.text = eventitem.eventName
        if let mainImageUrl = eventitem.eventImage{
            cell.eventImage.loadImageUsingCacheWithUrlString(mainImageUrl)
            cell.eventImage.contentMode = .ScaleAspectFit
            cell.eventImage.clipsToBounds = true
        }
        
        return cell
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        storageRef = FIRStorage.storage().referenceForURL(eventType[indexPath.row].eventImage)
        
        let itemSelected = eventType[indexPath.row]
        storageRef.dataWithMaxSize(1 * 1024 * 1024)
        { (data, error) in
            if error == nil
            {// if 1
                dispatch_async(dispatch_get_main_queue(),
                { //diss
                    if let data = data
                    { //if 2
                        
                        let detailVC:AddEventViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AddEventViewController") as! AddEventViewController
                            detailVC.eventname = itemSelected.eventName
                            detailVC.eventimage = UIImage(data: data)!
                            self.presentViewController(detailVC, animated: true, completion: nil)
                    } // end if 2
                } // end diss
            
            )}//end if1
    
            else
            {
                print(error!.localizedDescription)
            }
        }
        
            
        
    }
    override func viewWillAppear(animated: Bool) {
        let postRef = FIRDatabase.database().reference().child("eventype")
        
        postRef.observeEventType(.Value, withBlock: { (snapshot) in
            var newPosts = [AddEventType]()
            for post in snapshot.children{
                let post = AddEventType(snapshot: post as! FIRDataSnapshot)
                
                    newPosts.insert(post, atIndex: 0)
                
            }
            self.eventType = newPosts
            
            dispatch_async(dispatch_get_main_queue(), {
                self.eventTypeCollectionView.reloadData()
            })
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 1
        
        return CGSize(width: width, height: width)
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    @IBAction func BackAction(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let showEvent : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("EventTabbar")
        self.presentViewController(showEvent, animated: true, completion: nil)
    }
}
