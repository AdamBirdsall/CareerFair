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
    // https://docs.google.com/forms/d/1uWmQ9CmC_As92Xv4jr33fT_1al7P2S2P1TGAGX4LvJs/formResponse
    
    // Name
    // entry.2005620554
    
    // Email
    // entry.1045781291
    
    // Comments
    // entry.839337160
    
    // Final URL
    // https://docs.google.com/forms/d/1uWmQ9CmC_As92Xv4jr33fT_1al7P2S2P1TGAGX4LvJs/formResponse? +
        // entry.2005620554=AdamAdam&entry.1045781291=Adam@gmail.com&entry.839337160=test&submit=Submit
    
    
    @IBAction func clickSubmit(sender: AnyObject) {
        
        //  https://docs.google.com/forms/d/YOUR_FORM_ID/formResponse?entry.1748727384=test&entry.1949164265=test&submit=Submit
        
        // Google sheets way
        //*********************
        let url = NSURL(string: "https://docs.google.com/forms/d/1uWmQ9CmC_As92Xv4jr33fT_1al7P2S2P1TGAGX4LvJs/formResponse")

        var postData = "entry.2005620554" + "=" + firstName.text! + lastName.text!
        postData += "&" + "entry.1045781291" + "=" + emailField.text!
        postData += "&submit=Submit"
        
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData.dataUsingEncoding(NSUTF8StringEncoding)
        _ = NSURLSession.sharedSession().dataTaskWithRequest(request).resume()
   
        // Parse way
        //*********************
        /*let newStudent = PFObject(className: "SignUps")
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
        }*/
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goToResume") {
            
            let destination = segue.destinationViewController as! ResumeViewController
            
            let info:Info = Info()
            info.firstName = firstName.text!
            info.lastName = lastName.text!
            info.email = emailField.text!
            
            destination.info = info
        }
    }

}

