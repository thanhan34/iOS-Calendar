//
//  ThirdViewController.swift
//  To Do List
//
//  Created by Doan Thanh An on 12/08/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

var finishList:[ToDoItem] = [ToDoItem]()

class ThirdViewController: UIViewController, UITableViewDelegate {
    
    

    @IBOutlet weak var finishListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finishList.count
    }
    
    
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! myFinishCell
        let todoItem = finishList[indexPath.row]
        cell.myFinishImageView.image = todoItem.imageName
        cell.myFinishLabel.text = todoItem.description
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            finishList.removeAtIndex(indexPath.row)
            
            // NSUserDefaults.standardUserDefaults().setObject(ToDoItem.self, forKey: "ToDoItem")
            // NSUserDefaults.standardUserDefaults().setObject(ToDoItem.self, forKey: "arraytodolist")
            
            finishListTable.reloadData()
        }
    }
    override func viewDidAppear(animated: Bool) {
        
        finishListTable.reloadData()
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let itemSelected = finishList[indexPath.row]
        let detailVC:DetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailVC.imageDetail = itemSelected.imageName!
        detailVC.descriptionDetail = itemSelected.description
        
        self.presentViewController(detailVC, animated: true, completion: nil)
        
    }
    
    
}