//
//  RestaurantProfileViewController.swift
//  SplitTab
//
//  Created by Alex Lostak on 4/8/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import UIKit
import Alamofire

class RestaurantProfileViewController: UIViewController {
    
    @IBOutlet weak var restaurantNameUILabel: UILabel!
    @IBOutlet weak var distanceAwayUILabel: UILabel!
    @IBOutlet weak var userVisitsUILabel: UILabel!
    
    @IBOutlet weak var cuisineUILabel: UILabel!
    @IBOutlet weak var hoursOfOpLabel: UILabel!
    @IBOutlet weak var locationUILabel: UILabel!
    var restaurant = Restaurant();
    override func viewDidLoad() {
        super.viewDidLoad();
        
        loadProfile();
        getProfile();
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadProfile() {
        //get restaurant from server
        let restaurantName = "EER Eatery";
        let userVisits = 4;
        let cuisine = "American";
        let address = "301 East Dean Keaton St.";
        restaurant?.restaurantName = restaurantName;
        restaurant?.userVisits = userVisits;
        restaurant?.cuisine = cuisine;
        restaurant?.address = address;
        
        //update labels
        restaurantNameUILabel.text = restaurant?.restaurantName;
        //add string logic for user visits
        userVisitsUILabel.text = "You've visited here " + "\(restaurant?.userVisits ?? 2)" + " times";
        cuisineUILabel.text = restaurant?.cuisine;
        locationUILabel.text = restaurant?.address;
    }
    
    func getProfile() {
        let urlString = "http://52.186.120.85/getRest"
        let restID = 1;
        let parameters: Parameters = [
            "restID": restID
        ]
        print("** GETTING RESTAURANT **")
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { response in
            //print("Request: \(String(describing: response.request))")   // original url request
            //print("Response: \(String(describing: response.response))") // http url response
            //print("Result: \(response.result)")                         // response serialization result
            if let dictionary = response.result.value as? [String: Any] {
                print ("\(String(describing: dictionary))");
                if let name = dictionary["name"] as? String {
                    if let location = dictionary["location"] as? String {
                        self.restaurant?.restaurantName = name;
                        self.restaurant?.address = location;
                    }
                }
                    
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
