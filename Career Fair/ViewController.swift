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
import Firebase

/*
*
* URL for the Spreadsheet - https://docs.google.com/spreadsheets/d/1y3rA3xTLBpoBcNJazQqJkBqfapJXlf-3t5GO4RJF084/edit#gid=2075219940
* URL for the Google Form - https://docs.google.com/forms/d/1uWmQ9CmC_As92Xv4jr33fT_1al7P2S2P1TGAGX4LvJs/viewform
*
*/

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var studentSubmitButton: UIButton!
    @IBOutlet weak var employerSubmitButton: UIButton!
    
    @IBOutlet weak var gradSwitch: UISwitch!
    
    @IBOutlet weak var comments: UITextView!
    @IBOutlet weak var studentView: UIView!
    @IBOutlet weak var employerView: UIView!
    @IBOutlet weak var gradePicker: UIPickerView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    var imagePicker: UIImagePickerController = UIImagePickerController()
    
    var underOrGrad: String = ""

    
    var pickerDataSource = ["Select Grade","A+","A","A-","B+","B","B-","C+","C","C-","D+","D","D-","F"]
    var grade : String!
    let locationManager = CLLocationManager()
    let fireBaseUrl = "https://careerfair.firebaseio.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.employerView.alpha = 0.0
        
        self.gradePicker.dataSource = self
        self.gradePicker.delegate = self

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
            
            self.hideKeyboard()
            
            if (gradSwitch.on) {
                self.underOrGrad = "Graduate"
            } else {
                self.underOrGrad = "Undergraduate"
            }
            // The animations fade the views in and out for the student and employer
            
            let alert = UIAlertController(title: "Thank you!", message:"Please give iPad back.", preferredStyle: .Alert)
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
        
        // If the user doesn't select from the picker, 'grade' never gets assigned
        if (self.grade == nil) {
            // This makes sure there isn't an error for undefined grade
            self.grade = ""
        }
        
        var data: NSData = NSData()
        
        if let image = photoImageView.image {
            data = UIImageJPEGRepresentation(image,0.1)!
        }
                
        let fireBaseRequest : FirebasePost = FirebasePost(firstName: self.firstName.text!, lastName: self.lastName.text!, emailString: self.emailField.text!, commentsString: self.comments.text!, gradeString: self.grade, locationString: "Scottsdale", resumeImage: data, gradOrUnder: self.underOrGrad)
        fireBaseRequest.sendRequest()
        
        self.hideKeyboard()
        // Animation bringing the student view back and resetting all of the text fields
        
        let alert = UIAlertController(title: "Thank you!", message:nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
            
            self.gradePicker.selectRow(0, inComponent: 0, animated: false)

            UIView.animateWithDuration(0.5, animations: {
                
                self.employerView.alpha = 0.0
                self.firstName.text = ""
                self.lastName.text = ""
                self.emailField.text = ""
                self.comments.text = ""
                
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.firstName.resignFirstResponder()
        self.lastName.resignFirstResponder()
        self.emailField.resignFirstResponder()
        self.comments.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.firstName.resignFirstResponder()
        self.lastName.resignFirstResponder()
        self.emailField.resignFirstResponder()
        self.comments.resignFirstResponder()
        return true
    }
    
    func hideKeyboard() {
        self.firstName.resignFirstResponder()
        self.lastName.resignFirstResponder()
        self.emailField.resignFirstResponder()
        self.comments.resignFirstResponder()
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
            //self.grade = grade.stringByReplacingOccurrencesOfString("+", withString: "%2B")
        }
    }
    
   
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        photoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK:- Add Picture
    
    @IBAction func addPicture(sender: AnyObject) {
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera
            
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.delegate = self
            presentViewController(imagePicker, animated: true, completion:nil)
        }
    }
}

