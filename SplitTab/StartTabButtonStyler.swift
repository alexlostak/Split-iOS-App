//
//  StartTabButtonStyler.swift
//  SplitTab
//
//  Created by Alex Lostak on 3/6/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import UIKit

func StyleStartTabButton(startTabButton: UIButton) {
    startTabButton.layer.cornerRadius = 14;
    startTabButton.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.95, alpha: 1.0).cgColor;
    startTabButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16);
    
//    payButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20);
//
//    payButton.setTitle("Pay", for: .normal);
//    payButton.layer.borderWidth = 1;
//    payButton.layer.borderColor = UIColor(red:0.00, green:0.89, blue:0.74, alpha:1.0).cgColor;
//    payButton.layer.cornerRadius = 14;
    return;
}
