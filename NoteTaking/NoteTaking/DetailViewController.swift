//
//  DetailViewController.swift
//  NoteTaking
//
//  Created by Yingbo Liu on 1/12/16.
//  Copyright © 2016 Yingbo Liu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UITextView!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
       
            if let label = self.detailDescriptionLabel {
                label.text = objects[currentIndex]
                if label.text == blank_note{
                    label.text = ""
                }
            }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        detailViewController = self
        detailDescriptionLabel.becomeFirstResponder()
        detailDescriptionLabel.delegate = self
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if objects.count == 0{
            return
        }
        objects[currentIndex] = detailDescriptionLabel.text
        
        if detailDescriptionLabel.text == ""{
            
            objects[currentIndex] = blank_note
        }
        saveAndUpdate()
    }
    
    
    func saveAndUpdate(){
        
        masterView?.save()
        masterView?.tableView.reloadData()
    }
    
    
    func textViewDidChange(textView: UITextView) {
        objects[currentIndex] = detailDescriptionLabel.text
        saveAndUpdate()
    }
    
    
    
    
    
    
    
    
    
    
    

}

