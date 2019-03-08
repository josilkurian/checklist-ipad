//
//  ViewControllerTableViewCell.swift
//  Checklist
//
//  Created by Josil K M on 9/4/18.
//  Copyright © 2018 Josil K M. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var deviceName: UILabel!
    @IBOutlet weak var deviceChecker: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onCheckerToggle(_ sender: Any) {
        if deviceChecker.isOn{
            ViewController.selectedDevices.append(deviceName.text!)
        }
    }
}
