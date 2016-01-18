//
//  AppDelegate.swift
//  LYControllerBindings
//
//  Created by Yingbo Liu on 1/18/16.
//  Copyright © 2016 Yingbo Liu. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // instances 
    var notes = [Note]()

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

