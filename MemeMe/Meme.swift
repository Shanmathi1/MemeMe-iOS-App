//
//  Meme.swift
//  MemeMe
//
//  Created by Shanmathi Mayuram Krithivasan on 11/21/15.
//  Copyright © 2015 Shanmathi Mayuram Krithivasan. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText: String = ""
    var botText: String = ""
    var originalImage: UIImage
    var memedImage : UIImage
    
    init (topText: String, botText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.botText = botText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
    func save() {
        Meme.getStorage().memes.append(self)
    }
    
    static func getStorage() -> AppDelegate {
        let object = UIApplication.sharedApplication().delegate
        return object as! AppDelegate
    }
    
    static func findAll() -> [Meme] {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return Meme.getStorage().memes
    }
    
    static func countAll() -> Int {
        return Meme.getStorage().memes.count
    }
    
    static func getAtIndex(index: Int) -> Meme? {
        if Meme.getStorage().memes.count > index {
            return Meme.getStorage().memes[index]
        }
        return nil
    }
    
    static func removeAtIndex(index: Int) {
        if index >= 0 && Meme.getStorage().memes.count > index {
            Meme.getStorage().memes.removeAtIndex(index)
        }
    }
}

