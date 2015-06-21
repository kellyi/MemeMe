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
        collectionViewCellTopText.text = topText
        collectionViewCellBottomText.text = bottomText
        setTextAttributes()
    }
    
    // display text in meme-style font
    func setTextAttributes() {
        collectionViewCellTopText.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 10)!
        collectionViewCellBottomText.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 10)!
        collectionViewCellTopText.textColor = UIColor.whiteColor()
        collectionViewCellBottomText.textColor = UIColor.whiteColor()
    }

}
