//
//  ViewController.swift
//  ChatRoom
//
//  Created by Yingbo Liu on 1/20/16.
//  Copyright © 2016 Yingbo Liu. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate {

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func browse(sender: AnyObject) {
        self.presentViewController(browserViewController, animated: true, completion: nil)
   
    }
    @IBAction func sendMessage(sender: AnyObject) {
        do {
 
        try session.sendData((self.textField.text?.dataUsingEncoding(NSUTF8StringEncoding))!, toPeers: session.connectedPeers, withMode: .Reliable)
    }catch{
    
        print(error)
    }
        
    self.updateChat(self.textField.text!, fromPeer: self.peerID)
    self.textField.text = ""
    }
    
    let serviceType = "Class"
    var peerID:MCPeerID!
    var session:MCSession!
    var browserViewController: MCBrowserViewController!
    
    var assistant: MCAdvertiserAssistant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peerID = MCPeerID(displayName: "Yingbo")
        session = MCSession(peer: peerID)
        session.delegate = self
        
        browserViewController = MCBrowserViewController(serviceType: serviceType, session: session)
        
        
        browserViewController.delegate = self
        assistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: session)

        assistant.start()
        
    }

    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController) {
        browserViewController.dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController) {
        browserViewController.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        dispatch_async(dispatch_get_main_queue()) {
           () -> Void in
            if let msg = String(data: data, encoding: NSUTF8StringEncoding){
                
                self.updateChat(msg, fromPeer:peerID)
            }
            
        }
    }
    
    func updateChat(text:String, fromPeer peerID:MCPeerID){
        
        var name:String!
        switch peerID {
            
        case self.peerID:
            name = "me"
            
        default:
            name = peerID.displayName
        }
        
        let message = "\(name):\(text)\n"
        
        
        self.textView.text = self.textView.text + message
        
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }

    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
    }
    
    func session(session: MCSession, didReceiveCertificate certificate: [AnyObject]?, fromPeer peerID: MCPeerID, certificateHandler: (Bool) -> Void) {
        
    }
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        
    }
}

