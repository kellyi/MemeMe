//
//  MemeMeTableViewController.swift
//  MemeMe
//
//  Created by Kelly Innes on 6/14/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import UIKit

class MemeMeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var memes: [Meme]! = []
    
    @IBOutlet weak var memeTableView: UITableView!
    
    // MARK: - View Setup
    
    // populate memes array and reload table data on appearance
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        memeTableView.reloadData()
    }

    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeTableCell") as! UITableViewCell
        let meme = memes[indexPath.row]
        cell.textLabel!.text = "\(meme.topText) \(meme.bottomText)"
        cell.imageView?.image = meme.memeImage
        return cell
    }
    
    // push detail view on stack
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.row]
        let memeDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeDetailViewController.memeImage = meme.memeImage
        navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
}
