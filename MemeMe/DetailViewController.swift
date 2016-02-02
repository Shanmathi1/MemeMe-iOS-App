//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Shanmathi Mayuram Krithivasan on 11/24/15.
//  Copyright © 2015 Shanmathi Mayuram Krithivasan. All rights reserved.
//

import UIKit

/// Shows the meme in a full screen view
class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var meme: Meme!
    var indexOfMeme: Int?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = meme.memedImage
    }
    
    @IBAction func deleteButton(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let _ = indexOfMeme{
            appDelegate.memes.removeAtIndex(indexOfMeme!)
            navigationController?.popViewControllerAnimated(true)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEditor" {
            let destination = segue.destinationViewController as! EditorViewController
            destination.editMeme = meme
        }
    }
}
