//
//  TabTableViewController.swift
//  SplitTab
//
//  Created by Alex Lostak on 3/4/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import UIKit
import Alamofire

class TabTableViewController: UITableViewController {
    
    //Hard-coded ID values
    let userID = 2;
    let restID = 1;
    var tabID = 10;
    
    //variables for refreshing page
    var timer = Timer();
    var tickTock = true;
    
    //variabeles for Tab Data
    var openTab = Tab(tabItems: [TabItem]());
//    var menu = Menu(restID: 1);
    
    
    @IBOutlet weak var totalLabel: UILabel!
    

    @IBAction func claimSwitchTapped(_ sender: UISwitch) {
        let isOn = sender.isOn
        let row = sender.tag;
        var buttonCell = openTab.items[row];
        buttonCell.claimed = isOn;
        //print("item is claimed!!!!")
        if (isOn) {
            print("item is claimed!!!!")
            //post request to claimItem
            claimItem(item: buttonCell)
            
        } else {
            //post request to unclaimItem
            print("itme is unclaimed")
            unclaimItem(item: buttonCell)
        }
        openTab.updateTab();
        if let parentVC = self.parent as? TabViewController {
            parentVC.tipAmountLabel.text = "$" + String(format: "%.2f", openTab.tipAmount);
            parentVC.serviceAmountLabel.text = "$" + String(format: "%.2f", openTab.serviceAmount);
            parentVC.tabTotalLabel.text = "$" + String(format: "%.2f", openTab.total);
            
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //load sample data
        if let parentVC = self.parent as? TabViewController {
            openTab = parentVC.openTab;
        }
        print("** HERE IS TABLEVIEW TABID: \(String(describing: self.tabID))")
        
        getMenu();
        getTab();
        //loadSampleTabItems();
        //getTabItems(openTab: openTab);
        //initTab();
        startTimer();
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return openTab.items.count;
    }
    
    
    
   
    
    func claimItem (item: TabItem) {
        let urlString = "http://52.186.120.85/claimItem"
        let itemID = item.itemID;
//        let tabID = self.openTab.tabID;
        self.openTab.setTabID(tabID: self.tabID)
        let tabID = 26;
        let parameters: Parameters = [
            "userID": self.userID,
            "tabItemID": itemID,
            "tabID": self.tabID
        ]
        print("making claim post")
        print("users in userList before claiming")
        for user in item.userList {
            print("\(String(user))");
        }
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
        //add user to userList of this item, update claimed if not yet claimed
        item.userList.append(self.userID);
        item.updateCost();
        self.tableView.reloadData();
        
    }
    
    func unclaimItem(item: TabItem) {
        self.openTab.setTabID(tabID: self.tabID)
        let urlString = "http://52.186.120.85/unclaimItem"
        let itemID = item.itemID;
//        let tabID = self.openTab.tabID;
        let parameters: Parameters = [
            "userID": self.userID,
            "tabItemID": itemID,
            "tabID": self.tabID
        ]
        print("users in userList before unclaiming")
        for user in item.userList {
            print("\(String(user))");
        }
        print("making unclaim post")
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
        //remove user from item's userlist
        if (item.userList.contains(userID)) {
            item.userList = item.userList.filter { $0 != userID }
            
            if (item.userList.contains(userID)) {
                print("wtf user is still in userList")
            }
        } else {
            print("wtf user isn't even in the userlist")
        }
        item.updateCost();
        self.tableView.reloadData();
    }
    
    func startTimer() {
        
            // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.reloadTab), userInfo: nil, repeats: true)
    }
    
    private func itemOnTab(tabItemID: Int) -> Bool {
        let tabItemList = self.openTab.items;
        
        for tabItem in tabItemList {
            if (tabItem.itemID == tabItemID) {
                return true;
            }
        }
        return false;
    }
    
    
    
    
    @objc func reloadTab() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { // change 2 to desired number of seconds
            let urlString = "http://52.186.120.85/getTab"
            let tabID = self.tabID;
            let parameters: Parameters = [
                "tabID": tabID
            ]
            Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { response in
                print("** RELOADED TAB");
                //how we going to do this
                //so we already have the tab populated with items
                    /*
                 things that may change:
                 which users have claimed an item
                 an item could be added to the tab
                 
                 so how do we find out those changes
                 brute force:
                    for each tabItemID we check to see if we already have that tabItemID in the list of items
                        if we don't, just add it to our items
                        if we do
                            check to make sure item.userList is up to date
                 
                    */
                var serverTabIDs = [Int]();
                if let dictionary = response.result.value as? [String: Any] {
                    if let claimedItems = dictionary["claimedItems"] as? [Any] {
                        for item in claimedItems {
                            if let claimedItem = item as? [String: Any] {
                                if let userList = claimedItem["userList"] as? [Int] {
                                    if let tabItemID = claimedItem["tabItemID"] as? Int {
                                        //also need to get tab itemID
                                        serverTabIDs.append(tabItemID);
                                        if (self.itemOnTab(tabItemID: tabItemID)) {
                                            //check if userList matches
                                            var clientItem = self.openTab.getTabItemByID(tabItemID: tabItemID);
                                            clientItem.updateUserList(serverUserList: userList);
                                            clientItem.updateCost();
                                        } else {
                                            //update total
                                            if let itemID = claimedItem["itemID"] as? Int {
                                                let menuItem = self.openTab.menu.menu[itemID];
                                                var claimed = false;
                                                for user in userList {
                                                    if (user == self.userID) {
                                                        claimed = true;
                                                    }
                                                }
                                                guard let tabItem = TabItem (name: (menuItem?.name)!, cost: (menuItem?.cost)!, claimed: claimed, itemID: tabItemID, userList: userList) else {
                                                    fatalError("Failed to create tabItem");
                                                }
                                                //use itemID to get cost and price from the menu
                                                //create new item using all required info
                                                //append that item to tab
                                                self.openTab.items.append(tabItem);
                                        }
                                            print("Tab has \(self.openTab.items.count) items")
                                            
                                        }
                                    }
                                }
                                
                            }
                        }
                        
                    }
                }
                self.openTab.checkForRemovedItems(tabItemIDs: serverTabIDs);
                self.tableView.reloadData();
//            }
        }
        //check if okay to checkout
        let updatePayUIBUtton = self.openTab.canCheckout();
        if (updatePayUIBUtton) {
            print("Can checkout");
            
        }
        
        
        if (self.tickTock) {
            print("tick");
            self.tickTock = false;
        } else {
            print("tock");
            self.tickTock = true;
        }
    }
    
    func getMenu() {
        self.openTab.menu.loadMenu();
    }
    
    private func getTab() {
        self.openTab.setTabID(tabID: self.tabID)
        let urlString = "http://52.186.120.85/getTab"
        let tabID = self.tabID;
        let parameters: Parameters = [
            "tabID": tabID
        ]
        
        print("** GETTING TAB **")
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { response in
            //print("Request: \(String(describing: response.request))")   // original url request
            //print("Response: \(String(describing: response.response))") // http url response
            //print("Result: \(response.result)")                         // response serialization result
            if let dictionary = response.result.value as? [String: Any] {
                print ("\(String(describing: dictionary))");
//                if let tabID = dictionary["tableID"] as? Int {
//                    self.openTab.tabID = tabID;
//                }
                if let claimedItems = dictionary["claimedItems"] as? [Any] {
                    for item in claimedItems {
                        if let claimedItem = item as? [String: Any] {
                            if let userList = claimedItem["userList"] as? [Int] {
                                if let tabItemID = claimedItem["tabItemID"] as? Int {
                                    //also need to get tab itemID
                                    if let itemID = claimedItem["itemID"] as? Int {
                                        let menuItem = self.openTab.menu.menu[itemID];
                                        var claimed = false;
                                        for user in userList {
                                            if (user == self.userID) {
                                                claimed = true;
                                            }
                                        }
                                        if (userList.count == 0) {
                                            let nonEmptyUserList = [Int]();
                                            guard let tabItem = TabItem (name: (menuItem?.name)!, cost: (menuItem?.cost)!, claimed: claimed, itemID: tabItemID, userList: nonEmptyUserList) else {
                                                fatalError("Failed to create tabItem");
                                            }
                                            self.openTab.items.append(tabItem);
                                            print ("checking itemID: \(tabItem.itemID)");
                                            print("Tab has \(self.openTab.items.count) items")
                                        } else {
                                            guard let tabItem = TabItem (name: (menuItem?.name)!, cost: (menuItem?.cost)!, claimed: claimed, itemID: tabItemID, userList: userList) else {
                                                fatalError("Failed to create tabItem");
                                            }
                                            self.openTab.items.append(tabItem);
                                            print ("checking itemID: \(tabItem.itemID)");
                                            print("Tab has \(self.openTab.items.count) items")
                                        }
                                        
                                        //use itemID to get cost and price from the menu
                                        //create new item using all required info
                                        //append that item to tab
                                        
                                        
                                    }
                                }
                            }
                            
                        }
                    }
                }
                //get list of items on tab
                //add list to Tab TableView
                self.tableView.reloadData();
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TabTableViewCell";
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TabTableViewCell else {
            fatalError("The dequeued cell is not an instance of TabTableViewCell")
        }
        let tabItem = openTab.items[indexPath.row]
        cell.itemNameLabel.text = tabItem.name;
        cell.itemCostLabel.text = "$" + String(format: "%.2f", tabItem.cost);
        cell.itemClaimedSwitch.isOn = tabItem.claimed;
        cell.itemClaimedSwitch.tag = indexPath.row;
        return cell
    }
    
    private func initTab() {
        openTab.updateTab();
        if let parentVC = self.parent as? TabViewController {
            parentVC.tipAmountLabel.text = "$" + String(format: "%.2f", openTab.tipAmount);
            parentVC.tabTotalLabel.text = "$" + String(format: "%.2f", openTab.total);
        }
        return;
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
