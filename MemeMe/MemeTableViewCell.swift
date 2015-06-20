//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Kelly Innes on 6/19/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var tableCellText: UILabel!
    
    @IBOutlet weak var tableCellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
