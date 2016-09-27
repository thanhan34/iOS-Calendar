//
//  NetworkingService.swift
//  To Do List
//
//  Created by Doan Thanh An on 5/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

struct NetworkingService {
    var databaseRef: FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
    var storageRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    private func saveInfo(user: FIRUser!, username: String, password: String){
        // Create user dictionary info
        let userInfo = ["email": user.email!,"username": username,"uid": user.uid,"photoUrl": String(user.photoURL!)]
        // create user reference
        let userRef = databaseRef.child("users").child(user.uid)
        // save user infor in database
        userRef.setValue(userInfo)
       // Sigining in user
        signIn(user.email!, password: password)
        
        
    }
    func signIn(email: String, password: String){
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    print ("\(user.displayName!) has signed in succesfully!")
                    let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDel.logUser()
                }
                else {
                    print(error!.localizedDescription)
                }
            }
            
        })
    }
    
    private func setUserInfo(user: FIRUser!, username: String, password: String, data: NSData!){
        
        //Creae Path for the User Image
        let imagePath = "profileImage\(user.uid)/userPic.ipg"
        // Create image Reference
        let imageRef = storageRef.child(imagePath)
        // Create Metadata for the image
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        //save the user image in Firebase Storage File
        imageRef.putData(data, metadata: metaData) { (metaData, error) in
            if error == nil {
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData!.downloadURL()
                changeRequest.commitChangesWithCompletion({ (error) in
                    if error == nil {
                        self.saveInfo(user, username: username, password: password)
                    } else {
                        print (error!.localizedDescription)
                    }
                })
            } else {
                print(error!.localizedDescription)
            }
        
    }
    }
    func resetPassword(email: String){
        FIRAuth.auth()?.sendPasswordResetWithEmail(email, completion: { (error) in
            if error == nil {
                print("An email with information on how to reset password has been sent to you. Thank you")
            }
            else {
                print(error!.localizedDescription)
            }
        })
    }
    func signUp(email: String, username: String, password: String, data: NSData!){
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
            if error == nil {
                self.setUserInfo(user, username: username, password: password, data: data)
            } else {
                print (error!.localizedDescription)
            }
        })
    }
    
    
    
}
