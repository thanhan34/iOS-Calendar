//
//  AddEventType.swift
//  To Do List
//
//  Created by Doan Thanh An on 25/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct AddEventType{
    var eventImage: String!
    var eventName: String!
    var ref: FIRDatabaseReference?
    var key: String
    
    
    init (eventImage: String, eventName: String, key: String = ""){
        self.eventImage = eventImage
        self.eventName = eventName
        self.key = key
        self.ref = FIRDatabase.database().reference()
    }
    
    init(snapshot: FIRDataSnapshot){
        self.eventImage = snapshot.value!["eventImage"] as? String ?? ""
        self.eventName = snapshot.value!["eventName"] as? String ?? ""
        self.key = snapshot.key
        self.ref = snapshot.ref
        
    }
    func toAnyObject() -> [String: AnyObject] {
        return ["eventImage": eventImage, "eventName": eventName]
    }
    
}