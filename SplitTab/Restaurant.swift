//
//  Restaurant.swift
//  SplitTab
//
//  Created by Alex Lostak on 4/23/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import Foundation
class Restaurant {
    var restaurantName: String;
    var userVisits: Int;
    var cuisine: String;
    var address: String;
    var restID : Int;
    
    init?() {
        self.restaurantName = "";
        self.userVisits = 0;
        self.cuisine = "";
        self.address = "";
        self.restID = 1;
    }
    
    func updateRestaurant(restaurantName: String, userVisits: Int, cuisine: String, hoursOfOp: String, address: String) {
        self.restaurantName = restaurantName;
        self.userVisits = userVisits;
        self.cuisine = cuisine;
        self.address = address;
        self.restID = 1;
    }
}
