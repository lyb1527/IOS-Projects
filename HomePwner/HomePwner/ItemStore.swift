//
//  Item.swift
//  HomePwner
//
//  Created by Yingbo Liu on 1/21/16.
//  Copyright © 2016 Yingbo Liu. All rights reserved.
//
import UIKit

class ItemStore{
    
    var allItems = [Item]()
    
    func createItem() -> Item{
    
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    
    init(){
        for _ in 0...5{
            
            createItem()
        }
        
    }
}
    
    
    
    


































