//
//  StudentListViewController.swift
//  Career Fair
//
//  Created by Adam Birdsall on 3/23/16.
//  Copyright © 2016 Adam Birdsall. All rights reserved.
//

import UIKit
import Firebase

class StudentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var items = [NSDictionary]()
    
    let firebase = Firebase(url:"https://careerfair.firebaseio.com/students")

    override func viewDidLoad() {
        super.viewDidLoad()
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
//        cell.textLabel?.alpha = 0.0
//        cell.detailTextLabel?.alpha = 0.0
//        
//        let alert = UIAlertController(title: "Are you a student?", message:"", preferredStyle: .Alert)
//        
//        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (UIAlertAction) -> Void in
//            
//        }))
//        
//        alert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (UIAlertAction) -> Void in
//            
//            
//            UIView.animateWithDuration(0.3, animations: {
//                
//                cell.textLabel?.alpha = 1.0
//                cell.detailTextLabel?.alpha = 1.0
//                
//            })
//            
//            
//        }))
//        
//        self.presentViewController(alert, animated: true){}
    }
    
    
    
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
        
//         Configure the cell...
        cell.textLabel?.text = items[mainIndex]["firstName"] as? String
        cell.detailTextLabel?.text = items[mainIndex]["lastName"] as? String
        
        loadingIndicator.stopAnimating()
        self.mainTableView.alpha = 1.0
        
//        cell.textLabel?.text = "Main"
//        cell.detailTextLabel?.text = "Detail"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showDetails") {
            
        }
    }
}
