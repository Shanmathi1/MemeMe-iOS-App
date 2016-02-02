//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Shanmathi Mayuram Krithivasan on 11/24/15.
//  Copyright © 2015 Shanmathi Mayuram Krithivasan. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController{
    
    var selectedIndex: Int?
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        // set the Edit/Done button to the nav bar left button
        navigationItem.leftBarButtonItem = editButtonItem()
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        let dimension1 = (self.view.frame.size.height - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension1)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Display editor automatically if no memes
        if Meme.countAll() == 0 {
            performSegueWithIdentifier("showEditor", sender: self)
        }
        collectionView!.reloadData()
        // disable the button if there are no memes (after a delete)
        navigationItem.leftBarButtonItem?.enabled = Meme.countAll() > 0
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView!.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        cell.contentView.frame = cell.bounds;
        if let meme = Meme.getAtIndex(indexPath.row) {
            cell.memeImageView.image = meme.memedImage
        }
        
        cell.deleteButton.hidden = !editing
        cell.deleteButton.addTarget(self, action: "didPressDelete:", forControlEvents: .TouchUpInside)
        return cell
    }
    
    @IBAction func didPressDelete(sender: UIButton) {
        // need to get to the cell from the button
        let cell = sender.superview!.superview! as! MemeCollectionViewCell
        let index = collectionView!.indexPathForCell(cell)!
        Meme.removeAtIndex(index.row)
        collectionView!.deleteItemsAtIndexPaths([index]);
        setEditing(false, animated: true)
        navigationItem.leftBarButtonItem?.enabled = Meme.countAll() > 0
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Meme.countAll()
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        if !editing {
            performSegueWithIdentifier("showDetail", sender: self)
        }
    }
    
    @IBAction func didPressAdd(sender: AnyObject) {
        performSegueWithIdentifier("showEditor", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let destination = segue.destinationViewController as! DetailViewController
            if let meme = Meme.getAtIndex(selectedIndex!) {
                destination.meme = meme
                destination.indexOfMeme = selectedIndex
            }
        }
    }
}
