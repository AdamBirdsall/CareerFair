//
//  ResumeViewController.swift
//  Career Fair
//
//  Created by Adam Birdsall on 3/4/16.
//  Copyright © 2016 Adam Birdsall. All rights reserved.
//

import UIKit

class ResumeViewController: UIViewController {

    var info:Info = Info()

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameLabel.text = info.firstName
        lastNameLabel.text = info.lastName
        emailLabel.text = info.email
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
