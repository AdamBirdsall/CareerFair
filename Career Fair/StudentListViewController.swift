//
//  StudentListViewController.swift
//  Career Fair
//
//  Created by Adam Birdsall on 3/23/16.
//  Copyright © 2016 Adam Birdsall. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class StudentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var items = [NSDictionary]()
    
    let firebase = Firebase(url:"https://careerfair.firebaseio.com/students")
    
    var isEditting : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTableView.allowsMultipleSelectionDuringEditing = true

        loadDataFromFirebase()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        loadingIndicator.startAnimating()
        self.mainTableView.alpha = 0.0
        
        self.mainTableView.reloadData()
    }
    
    func loadDataFromFirebase() {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        firebase.observeEventType(.Value, withBlock: { snapshot in
            var tempItems = [NSDictionary]()
            
            for item in snapshot.children {
                let child = item as! FDataSnapshot
                let dict = child.value as! NSDictionary
                tempItems.append(dict)
            }
            
            self.items = tempItems
            self.mainTableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        cell?.backgroundColor = UIColor.clearColor()
//
//        if (self.isEditting == true) {
//            cell?.backgroundColor = UIColor.clearColor()
//        } else {
//            performSegueWithIdentifier("viewDetails", sender: nil)
//        }
//    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        
//        let firebaseItems: Student = Student(snapshot: items[indexPath.row])
        
        let mainIndex = indexPath.row
        
        // Configure the cell...
        cell.textLabel?.text = items[mainIndex]["fullName"] as? String
        cell.detailTextLabel?.text = items[mainIndex]["email"] as? String
        
        loadingIndicator.stopAnimating()
        self.mainTableView.alpha = 1.0
        
        return cell
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "viewDetails") {
            
            
            let destination = segue.destinationViewController as! StudentDetailsViewController
            
            let indexPath = self.mainTableView.indexPathForSelectedRow!
            
            // get object from your dataparse array using the indexPath
            let groupObject = self.items[indexPath.row]
            
            let info:Info = Info()
            info.firstName = groupObject["firstName"] as! String
            info.lastName = groupObject["lastName"] as! String
            info.email = groupObject["email"] as! String
            info.grade = groupObject["grade"] as! String
            info.resume = groupObject["resume"] as! String
            info.graduate = groupObject["gradOrUnder"] as! String
            
            destination.info = info
        }
    }
    
    @IBAction func editRows(sender: AnyObject) {
        if (mainTableView.editing == true) {
            self.mainTableView.setEditing(false, animated: true)
            self.isEditting = false
            return
        }
        self.isEditting = true
        self.mainTableView.setEditing(true, animated: true)
    }
    
}
