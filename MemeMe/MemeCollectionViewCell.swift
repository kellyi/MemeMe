//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Kelly Innes on 6/19/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionViewCellImage: UIImageView!
    
    @IBOutlet weak var collectionViewCellTopText: UILabel!
    
    @IBOutlet weak var collectionViewCellBottomText: UILabel!
    
    func setText(topText: String, bottomText: String) {
        self.collectionViewCellTopText.text = topText
        self.collectionViewCellBottomText.text = bottomText
        self.setTextAttributes()
    }
    
    func setTextAttributes() {
        self.collectionViewCellTopText.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 10)!
        self.collectionViewCellBottomText.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 10)!
        self.collectionViewCellTopText.textColor = UIColor.whiteColor()
        self.collectionViewCellBottomText.textColor = UIColor.whiteColor()
    }

}
