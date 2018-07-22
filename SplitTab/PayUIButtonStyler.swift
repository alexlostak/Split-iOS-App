//
//  PayUIButton.swift
//  SplitTab
//
//  Created by Alex Lostak on 3/5/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import UIKit


    func stylePayUIButtion(payButton: UIButton) {
        payButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20);
        //payButton.titleLabel?.textColor! = UIColor(red:0.139, green:0.140, blue:0.142, alpha:0.5);
        payButton.setTitle("Pay", for: .normal);
        payButton.layer.borderWidth = 2;
        payButton.layer.borderColor = UIColor(red:0.139, green:0.140, blue:0.142, alpha:0.5).cgColor;
        payButton.layer.cornerRadius = 14;
        return;
    }

func stylePayUIButtonForCheckout(payButton: UIButton) {
    payButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20);
    payButton.setTitle("Pay", for: .normal);
    payButton.layer.borderWidth = 2;
    payButton.layer.borderColor = UIColor(red:0.00, green:0.89, blue:0.74, alpha:1.0).cgColor;
    payButton.layer.cornerRadius = 14;
    return;
}
    
    func glowOnTap(payButton: UIButton) {
        payButton.layer.shadowColor = UIColor(red:0.00, green:0.89, blue:0.74, alpha:1.0).cgColor;
        payButton.layer.shadowRadius = 10.0;
        payButton.layer.shadowOpacity = 1.0;
//        payButton.setTitleShadowColor(UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.0), for: UIControlState.focused);
}
