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
    
    @IBAction func clickSubmit(sender: AnyObject) {
        
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
    
    // Google form URL
    // https://docs.google.com/forms/d/1OD_2Zs-TzZv3E_ZfFjnSn1I6CIXO-Ma8b3UUm2JDKjc/formResponse

    // Name
    // entry.2005620554
    
    // Email
    // entry.1045781291
    
    // Address
    // entry.1065046570
}

