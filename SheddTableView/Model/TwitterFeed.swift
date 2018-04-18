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
    
    /// Twitter tweet description
    var contentText: String
    
    /// The author for this feed
    let author: TwitterAuthor
    
    /**
     A basic initialiser.
     */
    init(feedID: String, contentText: String, author: TwitterAuthor) {
        self.feedID = feedID
        self.contentText = contentText
        self.author = author
    }
    
    /**
     Initialises object with a TWTRTweet object.
     - parameter tweet: The TWTRTweet object.
     */
    init(tweet: TWTRTweet) {
        
        let author = TwitterAuthor(id: tweet.author.userID, name: tweet.author.name, imageURL: tweet.author.profileImageLargeURL, tagUserName: "@\(tweet.author.screenName)")
        
        self.init(feedID: tweet.tweetID, contentText: tweet.text, author: author)
    }
    
    /**
     Initialises object using a managed object
     */
    init?(managedObject: NSManagedObject) {
        
        /// Find the feed fields
        guard let feedID = managedObject.value(forKey: TwitterFeedDBKey.tweetID.rawValue) as? String,
            let contentText = managedObject.value(forKey: TwitterFeedDBKey.contentText.rawValue) as? String else {
                return nil
        }
        
        /// Get the author relationship
        guard let author = managedObject.value(forKey: TwitterFeedDBKey.author.rawValue) as? NSManagedObject else {
            return nil
        }
        
        /// Find the author fields
        guard let authorID = author.value(forKey: TwitterAuthorDBKey.authorID.rawValue) as? String,
        let authorName = author.value(forKey: TwitterAuthorDBKey.name.rawValue) as? String,
        let authorImageURL = author.value(forKey: TwitterAuthorDBKey.imageURL.rawValue) as? String,
        let authorTagUserName = author.value(forKey: TwitterAuthorDBKey.tagUserName.rawValue) as? String else {
            return nil
        }
        
        /// Initialise
        let twitterAuthor = TwitterAuthor(id: authorID, name: authorName, imageURL: authorImageURL, tagUserName: authorTagUserName)
        
        self.init(feedID: feedID, contentText: contentText, author: twitterAuthor)
    }
}

/**
 This enum contains the type safe keys needed to communicate with CoreData regarding TwitterFeed objects.
 */
enum TwitterFeedDBKey: String {
    
    /// Feed ID
    case tweetID
    
    /// Author
    case author
    
    /// Tweet description
    case contentText
}
