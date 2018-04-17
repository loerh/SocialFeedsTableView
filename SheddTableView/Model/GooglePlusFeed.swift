//
//  GooglePlusFeed.swift
//  SheddTableView
//
//  Created by Laurent Meert on 16/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import CoreData

/**
 The Google Plus feed object's structure.
 */
struct GooglePlusFeed: SocialFeed {
    
    /// Twitter ID
    var feedID: String
    
    /// Twitter author
    var author: String
    
    /// Twitter image URL
    var imageURL: String
    
    /**
     A basic initialiser.
     */
    init(feedID: String, author: String, imageURL: String) {
        self.feedID = feedID
        self.author = author
        self.imageURL = imageURL
    }
}
