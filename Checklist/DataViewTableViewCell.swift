//
//  DataViewTableViewCell.swift
//  Checklist
//
//  Created by Josil K M on 9/18/18.
//  Copyright © 2018 Josil K M. All rights reserved.
//

import UIKit

class DataViewTableViewCell: UITableViewCell {

    @IBOutlet weak var KeyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
