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
    
}