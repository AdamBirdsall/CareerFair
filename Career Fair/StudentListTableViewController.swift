//
//  StudentListTableViewController.swift
//  Career Fair
//
//  Created by Adam Birdsall on 3/23/16.
//  Copyright © 2016 Adam Birdsall. All rights reserved.
//

import UIKit
import Firebase

class StudentListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.alpha = 0.0
        cell.detailTextLabel?.alpha = 0.0
        
        let alert = UIAlertController(title: "Are you a student?", message:"", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (UIAlertAction) -> Void in
            
            
            UIView.animateWithDuration(0.3, animations: {
                
                cell.textLabel?.alpha = 1.0
                cell.detailTextLabel?.alpha = 1.0
                
            })
            
            
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (UIAlertAction) -> Void in
            
        }))
        self.presentViewController(alert, animated: true){}
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = "Main Text"
        cell.detailTextLabel?.text = "Detail Text"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showDetails") {
            
        }
    }

}
