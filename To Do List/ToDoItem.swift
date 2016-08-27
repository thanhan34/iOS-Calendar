//
//  ToDoItem.swift
//  To Do List
//
//  Created by Doan Thanh An on 29/07/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class ToDoItem {
    var title: String
    var staff: String
    var location: String
    var starts: String
    var ends: String
    var rpeat: String
    var imageName: UIImage?
    var description: String
    var secondPhoto: UIImage?
    
    init (title: String,staff:String, location: String,starts: String, ends: String, rpeat: String, imageName: UIImage?, description: String, secondPhoto: UIImage?){
        self.title = title
        self.staff = staff
        self.location = location
        self.starts = starts
        self.ends = ends
        self.rpeat = rpeat        
        self.imageName = imageName
        self.description = description
        self.secondPhoto = secondPhoto
        
    }
    
    /*init (imageName: UIImage?, description: String){
        self.imageName = imageName
        self.description = description
    }
    */
  /*
    init(coder aDecoder: NSCoder!){
        self.title = aDecoder.decodeObjectForKey("Title") as! String
        self.staff = aDecoder.decodeObjectForKey("Staff") as! String
        self.location = aDecoder.decodeObjectForKey("Location") as! String
        self.starts = aDecoder.decodeObjectForKey("Start") as! String
        self.ends = aDecoder.decodeObjectForKey("End") as! String
        self.rpeat = aDecoder.decodeObjectForKey("Repeat") as! String
        self.imageName = aDecoder.decodeObjectForKey("FirstPhoto") as? UIImage
        self.description = aDecoder.decodeObjectForKey("Description") as! String
        self.secondPhoto = aDecoder.decodeObjectForKey("SecondPhoto") as? UIImage
    }*/
  /*  func initWithCoder(aDecoder: NSCoder) -> ToDoItem {
        self.title = aDecoder.decodeObjectForKey("Title") as! String
        self.staff = aDecoder.decodeObjectForKey("Staff") as! String
        self.location = aDecoder.decodeObjectForKey("Location") as! String
        self.starts = aDecoder.decodeObjectForKey("Start") as! String
        self.ends = aDecoder.decodeObjectForKey("End") as! String
        self.rpeat = aDecoder.decodeObjectForKey("Repeat") as! String
        self.imageName = aDecoder.decodeObjectForKey("FirstPhoto") as? UIImage
        self.description = aDecoder.decodeObjectForKey("Description") as! String
        self.secondPhoto = aDecoder.decodeObjectForKey("SecondPhoto") as? UIImage
        return self
    }
    func encodeWithCoder(aCoder: NSCoder!){
        aCoder.encodeObject(title, forKey: "Title")
        aCoder.encodeObject(staff, forKey: "Staff")
        aCoder.encodeObject(location, forKey: "Location")
        aCoder.encodeObject(starts, forKey: "Start")
        aCoder.encodeObject(ends, forKey: "End")
        aCoder.encodeObject(title, forKey: "Title")
        aCoder.encodeObject(rpeat, forKey: "Repeat")
        aCoder.encodeObject(imageName, forKey: "FirstPhoto")
        aCoder.encodeObject(description, forKey: "Description")
        aCoder.encodeObject(secondPhoto, forKey: "SecondPhoto")
    }
    */
}