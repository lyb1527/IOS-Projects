//
//  Note.swift
//  LYControllerBindings
//
//  Created by Yingbo Liu on 1/18/16.
//  Copyright © 2016 Yingbo Liu. All rights reserved.
//

import Cocoa

class Note: NSObject {
    
    var title = "new note"
        {
        didSet{
            edited = NSDate()
            
        }
            
    }
    var text:NSAttributedString =
    NSAttributedString(string:"new note")
        {
            
        didSet{
            
            edited = NSDate()
            
        }
    }
    
    
    var created = NSDate()
    var edited = NSDate()

}
