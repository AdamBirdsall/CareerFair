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

}
