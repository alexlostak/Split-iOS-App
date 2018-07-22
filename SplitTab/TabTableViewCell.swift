//
//  TabTableViewCell.swift
//  SplitTab
//
//  Created by Alex Lostak on 3/4/18.
//  Copyright © 2018 Alex Lostak. All rights reserved.
//

import UIKit

class TabTableViewCell: UITableViewCell {
    // MARK: Properties
    
    @IBOutlet weak var itemClaimedSwitch: UISwitch!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCostLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   


}
