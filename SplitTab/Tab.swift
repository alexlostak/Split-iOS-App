//
//  Tab.swift
//  SplitTab
//
//  Created by Alex Lostak on 3/6/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import Foundation
import Alamofire

class Tab {
    // MARK: Properties
    let tableCode: Int;
    var subTotal: Double;
    var tipPercentage: Double;
    var tipAmount: Double;
    let servicePercentage: Double;
    var serviceAmount: Double;
    var total: Double;
    var items: [TabItem];
    var tabID: Int;
    let restID: Int;
    var menu: Menu;
    
    
    init(tabItems: [TabItem]) {
        self.tableCode = 10;
        self.subTotal = 00.00;
        self.tipPercentage = 0.15;
        self.tipAmount = self.subTotal * self.tipPercentage;
        self.servicePercentage = 0.05;
        self.serviceAmount = self.subTotal * servicePercentage;
        self.total = subTotal + tipAmount + serviceAmount;
        self.items = tabItems;
        self.tabID = 2;
        self.restID = 1;
        self.menu = Menu(restID: self.restID)
    }
    
    func setTabID(tabID: Int) {
        self.tabID = tabID;
    }
    
    func updateSubTotal() {
        var newSubTotal = 0.0;
        for item in items {
            if (item.claimed) {
                newSubTotal += item.cost;
            }
        }
        self.subTotal = newSubTotal;
    }
    
    func updateTipAmount() {
        self.tipAmount = self.subTotal * self.tipPercentage;
    }
    
    func updateServiceAmount() {
        self.serviceAmount = self.subTotal * self.servicePercentage;
    }
    
    func updateTotal() {
        self.total = self.subTotal + self.tipAmount + self.serviceAmount;
    }
    
    func updateTab() {
        self.updateSubTotal();
        self.updateTipAmount();
        self.updateServiceAmount();
        self.updateTotal();
    }
    
    func getTabItemByID(tabItemID: Int) -> TabItem {
        for item in self.items {
            if (item.itemID == tabItemID) {
                return item;
            }
        }
        let item = TabItem(name: "", cost: 0.0, claimed: false, itemID: -1, userList: [])
        return item!;
    }

    func checkForRemovedItems(tabItemIDs: [Int]) {
        var removalIndexes = [Int]()
        var i = 0;
        for clientItem in self.items {
            if (!tabItemIDs.contains(clientItem.itemID)) {
                removalIndexes.append(i);
            }
            i += 1;
        }
        var removalCount = removalIndexes.count;
        while (removalCount > 0) {
            self.items.remove(at: removalIndexes[removalCount - 1]);
            removalCount = removalCount - 1;
        }
    }
    
    func canCheckout() -> Bool {
        for item in self.items {
            if (item.userList.isEmpty) {
                return false;
            }
        }
        return true;
    }
    
    func checkout() {
        let urlString = "http://52.186.120.85/splitCheckout"
        let parameters: Parameters = [
            "tabID": self.tabID
        ]
        print("** CHECKING OUT MOTHER FUCKER **");
        Alamofire.request(urlString, method: .post, parameters: parameters).responseString {
            response in
            switch response.result {
            case .success:
                print(response)
                
                break
            case .failure(let error):
                
                print(error)
            }
            
        }
        //return false;
    }
    
}
