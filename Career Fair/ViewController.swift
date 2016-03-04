//
//  ViewController.swift
//  Career Fair
//
//  Created by Adam Birdsall on 3/2/16.
//  Copyright © 2016 Adam Birdsall. All rights reserved.
//

import UIKit
import ParseUI

class ViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Google form URL
    // https://docs.google.com/forms/d/1OD_2Zs-TzZv3E_ZfFjnSn1I6CIXO-Ma8b3UUm2JDKjc/formResponse
    
    // Name
    // entry.2005620554
    
    // Email
    // entry.1045781291
    
    // Address
    // entry.1065046570
    
    @IBAction func clickSubmit(sender: AnyObject) {
        
        
        // Google sheets way
        //*********************
        let url = NSURL(string: "https://docs.google.com/forms/d/1OD_2Zs-TzZv3E_ZfFjnSn1I6CIXO-Ma8b3UUm2JDKjc/formResponse")
        var postData = "entry.2005620554" + "=" + firstName.text!
        postData += "&" + "entry.1045781291" + "=" + lastName.text!
        postData += "&" + "entry.1065046570" + "=" + emailField.text!
        postData += "&submit=Submit"
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData.dataUsingEncoding(NSUTF8StringEncoding)
//        var connection = NSURLConnection(request: request, delegate: nil, startImmediately: true)
        
        
        // Parse way
        //*********************
        let newStudent = PFObject(className: "SignUps")
        newStudent["First"] = firstName.text
        newStudent["Last"] = lastName.text
        newStudent["Email"] = emailField.text
        
        newStudent.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("Saved")
                
                let alert = UIAlertController(title: "Success!", message:"Thank you!", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                    self.firstName.text = ""
                    self.lastName.text = ""
                    self.emailField.text = ""
                }))
                self.presentViewController(alert, animated: true){}
                
            } else {
                
            }
        }
    }

}

