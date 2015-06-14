//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Kelly Innes on 6/13/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    func save() {
        //Create the meme
        var meme = Meme( text: textField.text!, image:
            imageView.image, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        appDelegate.memes.append(meme)
    }
    */

    @IBAction func cancelNewMeme(sender: AnyObject) {
        print("cancel\n")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareNewMeme(sender: AnyObject) {
        print("share\n")
    }
    
    @IBAction func newMemeFromCamera(sender: AnyObject) {
        createNewMeme("camera")
    }
    
    @IBAction func newMemeFromAlbum(sender: AnyObject) {
        createNewMeme("album")
    }
    
    func createNewMeme(from: String) {
        println(from)
    }
    
}
