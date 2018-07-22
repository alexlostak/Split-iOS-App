//
//  MenuItem.swift
//  SplitTab
//
//  Created by Alex Lostak on 4/24/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import Foundation

class MenuItem {
    let name: String;
    let cost: Double;
    let itemID: Int;
    
    init(name: String, cost: Double, itemID: Int ) {
        self.name = name;
        self.cost = cost;
        self.itemID = itemID;
    }
    
}
