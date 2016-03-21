//
//  HttpPost.swift
//  Career Fair
//
//  Created by Adam Birdsall on 3/14/16.
//  Copyright © 2016 Adam Birdsall. All rights reserved.
//

import Foundation

class HttpPost {
    
    var first: String
    var last: String
    var email: String
    var comments: String
    var grade: String
    var location: String
    var url: NSURL
    
    init (firstName: String, lastName: String, emailString: String, commentsString: String, gradeString: String, locationString: String, urlString: NSURL) {
        
        first = firstName
        last = lastName
        email = emailString
        comments = commentsString
        grade = gradeString
        location = locationString
        url = urlString
    }
    
    /*
    *
    * I want to put this into a try / catch, just so we know if the post went through
    * Not sure how to do a try / catch in Swift
    *
    */
    func sendRequest() -> Bool {
        
            let date:String = getDate()
            
            var postData = "entry.2005620554" + "=" + first + " " + last
            postData += "&" + "entry.1045781291" + "=" + email
            postData += "&" + "entry.839337160" + "=" + comments
            postData += "&" + "entry.1815108059" + "=" + grade
            postData += "&" + "entry.1424298971" + "=" + date
            postData += "&" + "entry.879470930" + "=" + location
            postData += "&submit=Submit"
            
            
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = postData.dataUsingEncoding(NSUTF8StringEncoding)
            _ = NSURLSession.sharedSession().dataTaskWithRequest(request).resume()
            
            return true;
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