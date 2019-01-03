//
//  CustomTableViewCell.swift
//  WeatherApp
//
//  Created by Hemanth on 26/12/18.
//  Copyright © 2018 Hemanth. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var timeLbl: UILabel!
    @IBOutlet var tempLbl: UILabel!
    
    @IBOutlet var summaryLbl: UILabel!
    
    @IBOutlet var units: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
