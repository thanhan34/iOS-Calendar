//
//  ToDoItemDatabase.swift
//  To Do List
//
//  Created by Doan Thanh An on 5/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

struct TodoItemDatabase {
    var username: String!
    var eventID: String!
    var title: String!
    var staff: String!
    var location: String!
    var starts: String!
    var ends: String!
    var rpeat: String!
    var imageName: String!
    var description: String!
    var secondPhoto: String!
    var ref: FIRDatabaseReference?
    var key: String!
    var isCompleted: Bool

    init (username: String, eventID: String, title: String, staff:String, location: String, starts: String, ends: String, rpeat: String, imageName: String, description: String, secondPhoto: String, key: String = "", isCompleted: Bool){
        self.username = username
        self.eventID = eventID
        self.title = title
        self.staff = staff
        self.location = location
        self.starts = starts
        self.ends = ends
        self.rpeat = rpeat
        self.imageName = imageName
        self.description = description
        self.secondPhoto = secondPhoto
        self.key = key
        self.ref = FIRDatabase.database().reference()
        self.isCompleted = isCompleted
    }
    init(snapshot: FIRDataSnapshot){
        self.username = snapshot.value!["username"] as? String ?? ""
        self.eventID = snapshot.value!["eventID"] as? String ?? ""
        self.title = snapshot.value!["title"] as? String ?? ""
        self.staff = snapshot.value!["staff"] as? String ?? ""
        self.location = snapshot.value!["location"] as? String ?? ""
        self.starts = snapshot.value!["starts"] as? String ?? ""
        self.ends = snapshot.value!["ends"] as? String ?? ""
        self.rpeat = snapshot.value!["rpeat"] as? String ?? ""
        self.imageName = snapshot.value!["imageName"] as? String ?? ""
        self.description = snapshot.value!["description"] as? String ?? ""
        self.secondPhoto = snapshot.value!["secondPhoto"] as? String ?? ""
        self.key = snapshot.key
        self.ref = snapshot.ref
        self.isCompleted = snapshot.value!["isCompleted"] as! Bool
    }
    func toAnyObject() -> [String: AnyObject] {
        return ["username": username, "eventID": eventID, "title": title, "staff": staff, "location": location, "starts": starts, "ends": ends, "rpeat": rpeat, "imageName": imageName, "description": description, "secondPhoto": secondPhoto, "isCompleted": isCompleted]
    }
    
}
