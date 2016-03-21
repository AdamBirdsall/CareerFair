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
    let ref: Firebase?
    
    let firstName: String!
    let lastName: String!
    let email: String!
    let comments: String!
    let grade: String!
    let location: String!
    let date: String!
    let image: NSData!
    
    // Initialize from arbitrary data
    init(key: String = "", firstName: String, lastName: String, emailString: String, commentsString: String, gradeString: String, locationString: String, dateString: String, resumeImage: NSData) {
        self.key = key
        self.ref = nil
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = emailString
        self.comments = commentsString
        self.grade = gradeString
        self.location = locationString
        self.date = dateString
        self.image = resumeImage
        
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
            "resume": base64String
        ]
    }
    
}
