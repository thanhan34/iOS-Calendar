//
//  User.swift
//  To Do List
//
//  Created by Doan Thanh An on 5/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct User{
    var username: String!
    var email: String!
    var photoUrl: String!
    var ref: FIRDatabaseReference?
    var key: String
    
    init(snapshot: FIRDataSnapshot){
        key = snapshot.key
        username = snapshot.value!["username"] as! String
        email = snapshot.value!["email"] as! String
        photoUrl = snapshot.value!["photoUrl"] as! String
        ref = snapshot.ref
    }
    
}
