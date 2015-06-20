//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Kelly Innes on 6/19/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    
    // outlets for meme image and text
    @IBOutlet weak var collectionViewCellImage: UIImageView!
    
    @IBOutlet weak var collectionViewCellTopText: UILabel!
    
    @IBOutlet weak var collectionViewCellBottomText: UILabel!
    
    // MARK: - Text setters
    
    // set text to given strings
    func setText(topText: String, bottomText: String) {
        self.collectionViewCellTopText.text = topText
        self.collectionViewCellBottomText.text = bottomText
        self.setTextAttributes()
    }
    
    // display text in meme-style font
    func setTextAttributes() {
        self.collectionViewCellTopText.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 10)!
        self.collectionViewCellBottomText.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 10)!
        self.collectionViewCellTopText.textColor = UIColor.whiteColor()
        self.collectionViewCellBottomText.textColor = UIColor.whiteColor()
    }

}
