//
//  TabViewController.swift
//  SplitTab
//
//  Created by Alex Lostak on 3/6/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class TabViewController: UIViewController {
    
    var openTab = Tab(tabItems: [TabItem]());
    var tableCode: Int?;
    var canCheckoutTimer = Timer();
    var styledForCheckout = false;
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tabTotalLabel: UILabel!
    @IBOutlet weak var serviceAmountLabel: UILabel!
    @IBOutlet weak var navBarTableCodeLabel: UINavigationItem!
    @IBOutlet weak var payButton: UIButton!
    @IBAction func payButtonTapped(_ sender: UIButton) {
        glowOnTap(payButton: payButton);
        if (openTab.canCheckout()) {
            stylePayUIButtonForCheckout(payButton: payButton);
            styledForCheckout = true;
            openTab.checkout();
            let finalizedReceipt = FinalRecViewController();
            var paymentSegue = "paymentSegue"
            performSegue(withIdentifier: paymentSegue, sender: self);
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        print("HERE IS THE TABLECODE FROM PREV VC")
        print(tableCode!);
        tabTotalLabel.text = "$00.00"
        var vc = childViewControllers.first as? TabTableViewController;
        //vc?.tabID = tableCode!;
        print(" TABLE VIEW VC SEEN FROM TAB\(String(describing: vc?.tabID))")
        openTab = ((childViewControllers.first as? TabTableViewController)?.openTab)!;
        
        //attempting to change title of navBar
        self.title = "Table " + String(format: "%d", openTab.tableCode);
        stylePayUIButtion(payButton: self.payButton);
        startTimer();
        
    }

    override func didReceiveMemoryWarning() { 
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "myEmbeddedSegue") {
            let childViewController = segue.destination as! TabTableViewController;
            childViewController.tabID = self.tableCode!;
        }
    }
    

    
    private func stylePayButton() {
        self.payButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20);
        
        self.payButton.setTitle("Pay", for: .normal);
        self.payButton.layer.borderWidth = 1;
        self.payButton.layer.borderColor = UIColor(red:0.00, green:0.89, blue:0.74, alpha:1.0).cgColor;
        self.payButton.layer.cornerRadius = 14;
        return;
    }
    
    private func startTimer() {
        
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        
        canCheckoutTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.checkForPayUIButtonStyling), userInfo: nil, repeats: true);
    }
    
    @objc private func checkForPayUIButtonStyling() {
        if (self.openTab.canCheckout()) {
            if (!styledForCheckout == true) {
                stylePayUIButtonForCheckout(payButton: payButton);
                styledForCheckout = true;
            }
        } else {
            if (styledForCheckout) {
                stylePayUIButtion(payButton: payButton)
                styledForCheckout = false;
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
