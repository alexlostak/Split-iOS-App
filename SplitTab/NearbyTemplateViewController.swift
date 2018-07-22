//
//  NearbyTemplateViewController.swift
//  SplitTab
//
//  Created by Alex Lostak on 3/6/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import UIKit

class NearbyTemplateViewController: UIViewController {

    @IBOutlet weak var irenesStartTabButton: UIButton!
    @IBOutlet weak var brickStartTabButton: UIButton!
    @IBOutlet weak var startTabTemplateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        StyleStartTabButton(startTabButton: startTabTemplateButton);
        StyleStartTabButton(startTabButton: brickStartTabButton);
        StyleStartTabButton(startTabButton: irenesStartTabButton);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
