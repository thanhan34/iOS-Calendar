//
//  Extensions.swift
//  To Do List
//
//  Created by Doan Thanh An on 17/09/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

let imageCache = NSCache()

extension UIImageView {
    func loadImageUsingCacheWithUrlString(urlString: String){
        self.image = nil
       //check cache for image first
        if let cachedImage = imageCache.objectForKey(urlString) as? UIImage {
            self.image = cachedImage
            return
        }
        //otherwise fire off a new download
        
        let url = NSURL(string: urlString)
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            // down load hit an error so lets return out
            if error != nil {
                print (error)
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                
                if let downloadedImage = UIImage(data: data!){
                
                imageCache.setObject(downloadedImage, forKey: urlString)
                self.image = downloadedImage
                }
            })
            
        }).resume()
    }
}
//extension String {
//    func stringAutoBuildToSpeech(title: String?, staff: String?, location: String?, starts: String?, ends: String?, rpeat: String?, description: String?) -> String {
//        var stringToSpeech: String = ""
//        let speechStringBuilder: [String: String] = [
//            "title" : title!,
//            "staff" : staff!,
//            "location" : location!,
//            "start" : starts!,
//            "end" : ends!,
//            "repeat" : rpeat!,
//            "description" : description!
//        ]
//        
//        if let titleString = speechStringBuilder["title"] {
//            if titleString != "" {
//                stringToSpeech = "You have a \(titleString) "
//            }
//            else {
//                stringToSpeech = " "
//            }
//        }
//        if let staffString = speechStringBuilder["staff"] {
//            if staffString != "" {
//                stringToSpeech = stringToSpeech + "with \(staffString) "
//            }
//            else {
//                stringToSpeech = stringToSpeech + " "
//            }
//        }
//        if let locationString = speechStringBuilder["location"] {
//            if locationString != "" {
//                stringToSpeech = stringToSpeech + "at \(locationString)"
//            }
//            else {
//                stringToSpeech = stringToSpeech + " "
//            }
//        }
//        if let startString = speechStringBuilder["start"] {
//            if startString != "" {
//                stringToSpeech = stringToSpeech + "from \(startString) "
//            }
//            else {
//                stringToSpeech = stringToSpeech + " "
//            }
//        }
//        if let endString = speechStringBuilder["end"] {
//            if endString != "" {
//                stringToSpeech = stringToSpeech + "to \(endString) "
//            }
//            else {
//                stringToSpeech = stringToSpeech + " "
//            }
//        }
//        if let repeatString = speechStringBuilder["repeat"] {
//            if repeatString != "" {
//                stringToSpeech = stringToSpeech + "It would be \(repeatString) time."
//            }
//            else {
//                stringToSpeech = stringToSpeech + " "
//            }
//        }
//        if let descriptionString = speechStringBuilder["description"] {
//            if descriptionString != "" {
//                stringToSpeech = stringToSpeech + "Detail about the event would be \(descriptionString)."
//            }
//            else {
//                stringToSpeech = stringToSpeech + " "
//            }
//        }
//        return stringToSpeech
//    
//    }
//    
//}
