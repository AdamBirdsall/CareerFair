//
//  Student.swift
//  Career Fair
//
//  Created by Adam Birdsall on 3/21/16.
//  Copyright © 2016 Adam Birdsall. All rights reserved.
//

import Foundation
import Firebase

struct Student {
    
    let key: String!
    
    let firstName: String!
    let lastName: String!
    let email: String!
    let comments: String!
    let grade: String!
    let location: String!
    let date: String!
    let image: NSData!
    let fullName: String!
    let gradOrUnder: String!
    
    // Initialize from data
    init(key: String = "", firstName: String, lastName: String, emailString: String, commentsString: String, gradeString: String, locationString: String, dateString: String, resumeImage: NSData, graduateStudent: String) {
        self.key = key
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = emailString
        self.comments = commentsString
        self.grade = gradeString
        self.location = locationString
        self.date = dateString
        self.image = resumeImage
        self.fullName = "\(firstName) \(lastName)"
        self.gradOrUnder = graduateStudent
        
    }
    
    init(snapshot: NSDictionary) {
        key = snapshot["key"] as! String
        firstName = snapshot["firstName"] as! String
        lastName = snapshot["lastName"] as! String
        grade = snapshot["grade"] as! String
        email = snapshot["email"] as! String
        comments = snapshot["comments"] as! String
        location = snapshot["location"] as! String
        date = snapshot["date"] as! String
        image = snapshot["resume"] as! NSData
        fullName = snapshot["fullName"] as! String
        gradOrUnder = snapshot["gradOrUnder"] as! String
    }
    
    /*
    * To decode the image -
    *
    *    let decodedData = NSData(base64EncodedString: imageString, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
    *
    *    let decodedImage = UIImage(data: decodedData!)
    *
    *    cell.imageView!.image = decodedImage
    */
    
    func toAnyObject() -> AnyObject {
        
        let base64String = image.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)

        return [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "comments": comments,
            "grade": grade,
            "location": location,
            "date": date,
            "resume": base64String,
            "fullName": fullName,
            "gradOrUnder": gradOrUnder
        ]
    }
    
}
