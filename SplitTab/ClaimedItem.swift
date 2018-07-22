//
//  ClaimedItem.swift
//  SplitTab
//
//  Created by Alex Lostak on 4/24/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import Foundation
class ClaimedItem {
    var itemID : Int;
    var userList : [Int];
    var claimed : Bool;
    
    init(itemID: Int, userList: [Int], claimed: Bool) {
        self.itemID = itemID;
        self.userList = userList;
        self.claimed = claimed;
    }
    
}
