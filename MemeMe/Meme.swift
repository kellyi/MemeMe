//
//  Meme.swift
//  MemeMe
//
//  Created by Kelly Innes on 6/13/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import UIKit

struct Meme {
    
    var topText: String
    var bottomText: String
    var originImage: UIImage
    var memeImage: UIImage
    
    init(top: String, bottom: String, originalImage: UIImage, newImage: UIImage) {
        self.topText = top
        self.bottomText = bottom
        self.originImage = originalImage
        self.memeImage = newImage
    }
}