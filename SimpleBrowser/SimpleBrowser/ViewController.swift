//
//  ViewController.swift
//  SimpleBrowser
//
//  Created by Yingbo Liu on 1/12/16.
//  Copyright © 2016 Yingbo Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var addressBar: UITextField!
    
  
    @IBOutlet weak var infoLabel: UILabel!

    @IBOutlet weak var webView: UIWebView!
//    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addressBar.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapGo(sender: AnyObject) {
        if addressBar.text == ""{
            return
        }
        guard let text: String = addressBar.text else {
            return
        }
        
        infoLabel.hidden = true
        //loadURL(text)
        if text.rangeOfString(".") != nil{
            var finalString: String = text.lowercaseString
            if finalString.rangeOfString("http://") == nil{
            
            finalString = "http://\(finalString)"
            }
        self.loadURL(finalString)
        }
        //no ., so a research
        else{
            let searchString = text.stringByReplacingOccurrencesOfString("", withString: "+")
            
            let finalString = "http://www.baidu.com/s?wd=\(searchString)"
            
            self.loadURL(finalString)
            
            shouldResignFirstResponder(addressBar)
            
        }
    }


    @IBAction func goBack(sender: AnyObject) {
        webView.goBack()
    
    }
    @IBAction func goForward(sender: AnyObject) {
        webView.goForward()
    
    }
    
   
    
    func loadURL(str:String){
        
        let url = NSURL(string: str)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }

    func shouldResignFirstResponder(textField: UITextField) ->Bool{
        
        
        textField.resignFirstResponder()
       
        return true
    }

}










