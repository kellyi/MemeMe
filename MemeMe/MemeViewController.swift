//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Kelly Innes on 6/13/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import UIKit

class MemeViewController: UITabBarController {
    
    // MARK: - IBActions
    
    // segue to Meme Editor View
    @IBAction func createNewMeme(sender: AnyObject) {
        let createNewMemeController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.presentViewController(createNewMemeController, animated: true, completion: nil)
    }
}
