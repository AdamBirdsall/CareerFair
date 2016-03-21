//
//  FirebasePost.swift
//  Career Fair
//
//  Created by Adam Birdsall on 3/21/16.
//  Copyright © 2016 Adam Birdsall. All rights reserved.
//



/*
// The root of the tree
// https://careerfair.firebaseio.com/

{
    "student": {
        
        "name": "Adam Birdsall",
        "email": "adam.birdsall@ticketmaster.com,
        "comments": "This is comments",
        "grade": "A+",
        "location": "Scottsdale",
        "date": "Mar 21, 2016"
    }
}
*/


import Foundation
import Firebase

class FirebasePost {
    
    let fireBaseUrl = "https://careerfair.firebaseio.com/student"
    
    var first: String
    var last: String
    var email: String
    var comments: String
    var grade: String
    var location: String
    var resume: NSData
    
    init (firstName: String, lastName: String, emailString: String, commentsString: String, gradeString: String, locationString: String, resumeImage: NSData) {
        
        first = firstName
        last = lastName
        email = emailString
        comments = commentsString
        grade = gradeString
        location = locationString
        resume = resumeImage
    }
    
    /*
    *
    * I want to put this into a try / catch, just so we know if the post went through
    * Not sure how to do a try / catch in Swift
    *
    */
    func sendRequest() -> Bool {
        
        let date:String = getDate()
        
        let rootRef = Firebase(url: "https://careerfair.firebaseio.com/students/\(self.first)%20\(self.last)")
        
//        if let image = photoImageView.image {
//            resume = UIImageJPEGRepresentation(image,0.1)!
//        }
//        let base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        

        let groceryItem = Student(firstName: self.first, lastName: self.last, emailString: self.email, commentsString: self.comments, gradeString: self.grade, locationString: "Scottsdale", dateString: date, resumeImage: resume)
        
        rootRef.setValue(groceryItem.toAnyObject())
        
        return true
    }
    
    /*
    *
    * This just gets the current date and updates the variable
    *
    */
    func getDate() -> String {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: date)
        _ = components.day
        
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.dateStyle = .MediumStyle
        let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        
        return DateInFormat
    }
    
}