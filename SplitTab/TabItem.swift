//
//  TabItem.swift
//  SplitTab
//
//  Created by Alex Lostak on 3/4/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import Foundation

class TabItem {
    //MARK: Properties
    var name: String;
    let origCost: Double;
    var cost: Double;
    var claimed: Bool;
    var itemID: Int;
    var userList: [Int];
    
//    init?(name: String, cost: Double, claimed: Bool, itemID: Int) {
//        if (name.isEmpty == true ) {
//            return nil;
//        }
//        self.name = name;
//        self.cost = cost;
//        self.claimed = claimed;
//        self.itemID = itemID;
//    }
    
    init?(name: String, cost: Double, claimed: Bool, itemID: Int, userList: [Int]) {
        if (name.isEmpty == true ) {
            return nil;
        }
        self.name = name;
        self.userList = userList;
        if (userList.count != 0) {
            self.cost = cost / Double(userList.count);
        } else {
            self.cost = cost;
        }
        self.origCost = cost;
        self.claimed = claimed;
        self.itemID = itemID;
        
    }
    
    func updateUserList(serverUserList: [Int]) {
        //not checking to make sure all client values are also in server list,
        //this could be an issue, but part of the reason I'm doing it is in the event that the client claims an item after
        //reloadTab() already downloaded the Tab then it shouldn't be in there.
        //unclaiming an item could cause the same issue but in that event the user would obviously just unclaim it again
        //so wouldn't be as bad of an error
        if (serverUserList.isEmpty) {
            return;
        }
        for userID in serverUserList {
            if(self.userList.isEmpty) {
                self.userList.append(userID);
            } else if (!(self.userList.contains(userID))) {
                self.userList.append(userID);
            }
        }
    }
    
    func updateCost() {
        print("** USERLIST COUNT \(String(describing: self.userList.count)) for \(String(describing: self.name))")
        let userCount = self.userList.count
        if (userCount <= 1) {
            self.cost = self.origCost;
            return;
        }
        self.cost = origCost/Double(userCount);

    }
    
    
}
