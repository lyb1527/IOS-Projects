    //
//  MasterViewController.swift
//  NoteTaking
//
//  Created by Yingbo Liu on 1/12/16.
//  Copyright © 2016 Yingbo Liu. All rights reserved.
//

import UIKit

    
// adding global variables
var objects:[String] = [String]()
var currentIndex: Int = 0
var masterView: MasterViewController?
var detailViewController: DetailViewController?
    
let kNotes:String = "notes"
let blank_note: String = "(New Note)"

    
class MasterViewController: UITableViewController {




    override func viewDidLoad() {
        super.viewDidLoad()
        masterView = self
        load()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
       
        
    }
    
    

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        save()
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        if objects.count == 0{
            
            insertNewObject(self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        
        //not able to add while editing 
        if detailViewController?.detailDescriptionLabel.editable == false{
            
            return
        }
        
        if objects.count == 0 || objects[0] != blank_note{
        objects.insert(blank_note, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
        currentIndex = 0
        self.performSegueWithIdentifier("showDetail", sender: self)
  
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //enable editing
        detailViewController?.detailDescriptionLabel.editable = true
        
        
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
               
                currentIndex = indexPath.row
            }
            let object = objects[currentIndex]
                // ? ignores everything else on the line if detailviewcontroller is nil
                // ! force unwrapped, if nil, app will break
                detailViewController?.detailItem = object
                detailViewController?.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                detailViewController?.navigationItem.leftItemsSupplementBackButton = true
            
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    //permanently delete the notes written before 
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing{
            detailViewController?.detailDescriptionLabel.editable = false
            detailViewController?.detailDescriptionLabel.text = ""
            return
        }
        save()
    }
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        detailViewController?.detailDescriptionLabel.editable = false
        detailViewController?.detailDescriptionLabel.text = ""
        save()
    }

    
    
    
    
    //save data to persistent storage 
    
    func save(){
        
        NSUserDefaults.standardUserDefaults().setObject(objects, forKey: kNotes)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    func load(){
        
        if let loadedData = NSUserDefaults.standardUserDefaults().arrayForKey(kNotes)as?[String]{
            
            objects = loadedData
        }
    }
    
    
    
}
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    

