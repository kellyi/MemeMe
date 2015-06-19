//
//  MemeMeCollectionViewController.swift
//  MemeMe
//
//  Created by Kelly Innes on 6/14/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import UIKit

class MemeMeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var memes: [Meme]!
    
    // MARK: - View Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }
    
    // MARK: - UICollectionViewDelegate

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as! UICollectionViewCell
        let meme = memes[indexPath.item]
        cell.setText(meme.topText, bottomString: meme.bottomText)
        let imageView = UIImageView(image: meme.memeImageName)
        cell.backgroundView = imageView
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        println("hello world")
    }
}
