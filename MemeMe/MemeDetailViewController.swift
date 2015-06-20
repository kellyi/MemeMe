//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Kelly Innes on 6/14/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var detailViewImage: UIImageView!
    
    var memeImage: UIImage?
    
    // MARK: - View Setup
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        detailViewImage.image = memeImage
    }

}
