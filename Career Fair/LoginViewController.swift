//
//  LoginViewController.swift
//  Career Fair
//
//  Created by Caleb King on 4/15/16.
//  Copyright © 2016 Adam Birdsall. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = Firebase(url: "https://careerfair.firebaseio.com/")
        
        
        ref.createUser("bobtony@example.com", password: "correcthorsebatterystaple",
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                } else {
                    let uid = result["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                }
        })
        
        ref.authUser("bobtony@example.com", password: "correcthorsebatterystaple",
            withCompletionBlock: { error, authData in
                if error != nil {
                    // There was an error logging in to this account
                } else {
                    // We are now logged in
                }
        })
        
        ref.changeEmailForUser("oldemail@example.com", password: "correcthorsebatterystaple",
            toNewEmail: "newemail@firebase.com", withCompletionBlock: { error in
                if error != nil {
                    // There was an error processing the request
                } else {
                    // Email changed successfully
                }
        })
        ref.changePasswordForUser("bobtony@example.com", fromOld: "correcthorsebatterystaple",
            toNew: "batteryhorsestaplecorrect", withCompletionBlock: { error in
                if error != nil {
                    // There was an error processing the request
                } else {
                    // Password changed successfully
                }
        })
        
        ref.resetPasswordForUser("bobtony@example.com", withCompletionBlock: { error in
            if error != nil {
                // There was an error processing the request
            } else {
                // Password reset sent successfully
            }
        })
        
        ref.removeUser("bobtony@example.com", password: "correcthorsebatterystaple",
            withCompletionBlock: { error in
                if error != nil {
                    // There was an error processing the request
                } else {
                    // Password changed successfully
                }
        })
    }

}
