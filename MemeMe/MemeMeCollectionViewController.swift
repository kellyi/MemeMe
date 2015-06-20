//
//  MemeMeCollectionViewController.swift
//  MemeMe
//
//  Created by Kelly Innes on 6/14/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import UIKit

class MemeMeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var memes: [Meme]! = []
    
    @IBOutlet weak var memeMeCollectionView: UICollectionView!
    
    // MARK: - View Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        self.memeMeCollectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDelegate

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.item]
        cell.setText(meme.topText, bottomText: meme.bottomText)
        cell.collectionViewCellImage.image = meme.originImage
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.item]
        println(meme.bottomText)
        let memeDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        self.navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
}
