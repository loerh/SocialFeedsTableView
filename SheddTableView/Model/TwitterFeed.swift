//
//  TwitterFeed.swift
//  SheddTableView
//
//  Created by Laurent Meert on 16/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import TwitterKit

/**
 The Twitter Feed structure.
 */
struct TwitterFeed: SocialFeed {
    
    /// Twitter ID
    var feedID: String
    
    /// Twitter author
    var author: String
    
    /// Twitter image URL
    var imageURL: String
    
    /// Twitter tweet description
    var tweetDescription: String
    
    /// The "@" tagged Twitter username
    var tagUsername: String
    
    /**
     A basic initialiser.
     */
    init(feedID: String, author: String, imageURL: String) {
        self.feedID = feedID
        self.author = author
        self.imageURL = imageURL
        self.tweetDescription = ""
        self.tagUsername = ""
    }
    
    /**
     Initialises object with a TWTRTweet object.
     - parameter tweet: The TWTRTweet object.
     */
    init(tweet: TWTRTweet) {
        self.init(feedID: tweet.tweetID, author: tweet.author.name, imageURL: tweet.author.profileImageLargeURL)
        self.tweetDescription = tweet.text
        self.tagUsername = "@\(tweet.author.screenName)"
        
    }
    
    /**
     Initialises object using a managed object
     */
    init?(managedObject: NSManagedObject) {
        
        guard let feedID = managedObject.value(forKey: TwitterFeedDBKey.tweetID.rawValue) as? String,
            let author = managedObject.value(forKey: TwitterFeedDBKey.author.rawValue) as? String,
            let imageURL = managedObject.value(forKey: TwitterFeedDBKey.imageURL.rawValue) as? String,
            let tweetDescription = managedObject.value(forKey: TwitterFeedDBKey.tweetDescription.rawValue) as? String,
            let tagUsername = managedObject.value(forKey: TwitterFeedDBKey.tagUsername.rawValue) as? String else {
                return nil
        }
        
        self.init(feedID: feedID, author: author, imageURL: imageURL)
        self.tweetDescription = tweetDescription
        self.tagUsername = tagUsername
    }
}

/**
 This enum contains the type safe keys needed to communicate with CoreData
 */
enum TwitterFeedDBKey: String {
    
    /// Feed ID
    case tweetID
    
    /// Author
    case author
    
    /// Image URL
    case imageURL
    
    /// Tweet description
    case tweetDescription
    
    /// Twitter "@" tagged username
    case tagUsername
}
