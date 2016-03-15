//
//  ViewController.swift
//  Career Fair
//
//  Created by Adam Birdsall on 3/2/16.
//  Copyright © 2016 Adam Birdsall. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBookUI


/*
*
* URL for the Spreadsheet - https://docs.google.com/spreadsheets/d/1y3rA3xTLBpoBcNJazQqJkBqfapJXlf-3t5GO4RJF084/edit#gid=2075219940
* URL for the Google Form - https://docs.google.com/forms/d/1uWmQ9CmC_As92Xv4jr33fT_1al7P2S2P1TGAGX4LvJs/viewform
*
*/

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var studentSubmitButton: UIButton!
    @IBOutlet weak var employerSubmitButton: UIButton!
    
    @IBOutlet weak var comments: UITextView!
    @IBOutlet weak var studentView: UIView!
    @IBOutlet weak var employerView: UIView!
    @IBOutlet weak var gradePicker: UIPickerView!
    
    var pickerDataSource = ["Select Grade","A+","A","A-","B+","B","B-","C+","C","C-","D+","D","D-","F"];
    var grade : String!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.employerView.alpha = 0.0
        
        self.gradePicker.dataSource = self;
        self.gradePicker.delegate = self;

        // Rounds the corners of the submit buttons
        self.studentSubmitButton.layer.cornerRadius = 10
        self.studentSubmitButton.clipsToBounds = true
        
        self.employerSubmitButton.layer.cornerRadius = 10
        self.employerSubmitButton.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Name
    // entry.2005620554
    
    // Email
    // entry.1045781291
    
    // Comments
    // entry.839337160
    
    // Grade
    // entry.1815108059
    
    // Location
    // entry.879470930
    
    // Date of Sign Up
    // entry.1424298971
    
    // Final URL
    // https://docs.google.com/forms/d/1uWmQ9CmC_As92Xv4jr33fT_1al7P2S2P1TGAGX4LvJs/formResponse? +
    // entry.2005620554=AdamAdam&entry.1045781291=Adam@gmail.com&entry.839337160=test&submit=Submit
    
    @IBAction func clickSubmit(sender: AnyObject) {
        
        if (firstName.text == "" || lastName.text == "" || emailField.text == "") {
            let alert = UIAlertController(title: "Invalid Entry", message:"Please fill in all of the fields.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
        } else if (!(isValidEmail(self.emailField.text!))) {
            let alert = UIAlertController(title: "Invalid Email", message:"Please enter a valid email.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                self.emailField.text = ""
            }))
            self.presentViewController(alert, animated: true){}
        } else {
            
            
            // The animations fade the views in and out for the student and employer
            
            let alert = UIAlertController(title: "Thank you!", message:"Please give iPad back to employer.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                
                UIView.animateWithDuration(0.5, animations: {
                    
                    self.studentView.alpha = 0.0
                    
                    UIView.animateWithDuration(0.5, animations: {
                        
                        self.employerView.alpha = 1.0
                        
                    })
                    
                })
                
            }))
            self.presentViewController(alert, animated: true){}
        }
    }

    
    @IBAction func employerSubmit(sender: AnyObject) {
        
        let url = NSURL(string: "https://docs.google.com/forms/d/1uWmQ9CmC_As92Xv4jr33fT_1al7P2S2P1TGAGX4LvJs/formResponse")
        
        // If the user doesn't select from the picker, 'grade' never gets assigned
        if (self.grade == nil) {
            // This makes sure there isn't an error for undefined grade
            self.grade = ""
        }
        
        // This makes the call to send the data to the google spreadsheet
        let postRequest : HttpPost = HttpPost(firstName: self.firstName.text!, lastName: self.lastName.text!, emailString: self.emailField.text!, commentsString: self.comments.text!, gradeString: self.grade, locationString: "Scottsdale", urlString: url!)
        postRequest.sendRequest()
        
        
        // Animation bringing the student view back and resetting all of the text fields
        
        let alert = UIAlertController(title: "Thank you!", message:nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
            
            UIView.animateWithDuration(0.5, animations: {
                
                self.employerView.alpha = 0.0
                self.firstName.text = ""
                self.lastName.text = ""
                self.emailField.text = ""
                self.comments.text = ""
                self.gradePicker.selectRow(0, inComponent: 0, animated: false)
                
                UIView.animateWithDuration(0.5, animations: {
                    
                    self.studentView.alpha = 1.0
                    
                })
                
            })
            
        }))
        self.presentViewController(alert, animated: true){}
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    /*
    * Picker View methods
    * For grading the students
    */
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.grade = pickerDataSource[row]
        
        if (grade == "Select Grade" || grade == nil) {
            self.grade = ""
        }
        if ((grade.rangeOfString("+")) != nil) {
            self.grade = grade.stringByReplacingOccurrencesOfString("+", withString: "%2B")
        }
    }
    
   
    /*
    *
    * Was thinking about doing location to get the current location, but there might be easier ways
    *
    */
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
}

