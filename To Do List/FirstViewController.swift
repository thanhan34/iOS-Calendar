//
//  FirstViewController.swift
//  To Do List
//
//  Created by Rob Percival on 16/01/2015.
//  Copyright (c) 2015 Appfish. All rights reserved.
//

import UIKit

var toDoList:[ToDoItem] = [ToDoItem]()

class FirstViewController: UIViewController, UITableViewDelegate {
    
    

    var arraykey: String!
    
    @IBOutlet var toDoListTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
      /* if NSUserDefaults.standardUserDefaults().objectForKey(arraykey) != nil {
        
        //   toDoList = NSUserDefaults.standardUserDefaults().objectForKey(arraykey) as! [ToDoItem]
            NSUserDefaults.standardUserDefaults().objectForKey(arraykey) as! [ToDoItem]
        }
        
         //NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "arraytodolist")
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        
        // cell.textLabel?.text = ToDoItem[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! myCell
        let todoItem = toDoList[indexPath.row]
        cell.myImageView.image = todoItem.imageName
        cell.myLabel.text = todoItem.description
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            toDoList.removeAtIndex(indexPath.row)
            
           // NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: arraykey)
            
            //NSUserDefaults.standardUserDefaults().setObject(ToDoItem.self, forKey: arraykey)
           // NSUserDefaults.standardUserDefaults().setObject(ToDoItem.self, forKey: "arraytodolist")
            
            toDoListTable.reloadData()
        }
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        toDoListTable.reloadData()
        
    }
   
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        let itemSelected = toDoList[indexPath.row]
        let detailVC:DetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailVC.titleEvent = itemSelected.title
        detailVC.staffEvent = itemSelected.staff
        detailVC.imageDetail = itemSelected.imageName!
        detailVC.locationEvent = itemSelected.location
        detailVC.startEvent = itemSelected.starts
        detailVC.endEvent = itemSelected.ends
        detailVC.repeatEvent = itemSelected.rpeat
        detailVC.secondPhotoEvent = itemSelected.secondPhoto!
        
        
        detailVC.descriptionDetail = itemSelected.description
        
        self.presentViewController(detailVC, animated: true, completion: nil)
      //  self.performSegueWithIdentifier("showDetail", sender: self)
        
    }
    

}

