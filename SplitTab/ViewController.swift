//
//  ViewController.swift
//  SplitTab
//
//  Created by Alex Lostak on 2/26/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    //MARK: Properties
    
    @IBOutlet weak var testSwitch: UISwitch!
    @IBOutlet weak var tableCodeLabel: UILabel!
    @IBOutlet weak var startTabLabel: UILabel!
    @IBOutlet weak var tableCodeTextField: UITextField!
    @IBAction func payButton(_ sender: UIButton) {
    }
    @IBAction func testSwitchTrigger(_ sender: Any) {
        print("did we catch the switch???")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        //tableCodeTextField.delegate = self
         //navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receiverVC = segue.destination as! TabViewController;
        if let text  = tableCodeTextField.text {
            let tableCode:Int? = Int(text);
            receiverVC.tableCode = tableCode!;
        }
        
        
        
        
        
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    //MARK: Actions

}

