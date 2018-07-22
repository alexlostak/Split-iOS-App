//
//  Menu.swift
//  SplitTab
//
//  Created by Alex Lostak on 4/24/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import Foundation
import Alamofire

class Menu {
    var menu: [Int: MenuItem]
    let restID: Int;
    
    init(restID: Int) {
        self.restID = restID;
        menu = [Int: MenuItem]();
    }
    
    func loadMenu() {
        let urlString = "http://52.186.120.85/getMenu"
        //make getMenu request to server
        Alamofire.request(urlString).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            print("\(String(describing: response.result.value))")
            if let itemList = response.result.value as?
                [Any] {
                print("** GOT DICTIONARY **")
                //print ("\(String(describing: itemList))");
                //get the items
                for item in itemList {
                    if let menuItem = item as? [String: Any] {
                        //print("\(String(describing: menuItem))")
                        if let itemName = menuItem["itemName"] as? String {
                            print("** GOT itemName **")
                            if let itemCost = menuItem["price"] as? Double {
                                print("** GOT itemID **")
                                if let itemID = menuItem["itemID"] as? Int {
                                    print("** GOT itemCost **")
                                    let newMenuItem = MenuItem(name: itemName, cost: itemCost, itemID: itemID);
                                    self.menu.updateValue(newMenuItem, forKey: itemID);
                                }
                            }
                        }
                    }
                }
                //print("\(String(describing: self.menu.count))");
            }
            //populate menu using response
        }
    }
}
