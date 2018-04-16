//
//  SocialFeed.swift
//  SheddTableView
//
//  Created by Laurent Meert on 15/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import TwitterKit

/**
 The Social Feed protocol provides guidelines for conforming classes/structs.
 */
protocol SocialFeed {
    
    /// The associated type that allows us to have a generic type for ID, as it can be String or Int
    associatedtype FeedID
    
    /// The feed ID
    var feedID: FeedID { get set }
    
    /// The feed author
    var author: String { get set }
    
    /// The feed image URL
    var imageURL: String { get set }
    
    /**
     A basic initialiser.
     - parameter author: The author of this social feed.
     - parameter imageURL: The image URL of this feed.
     */
    init(feedID: FeedID, author: String, imageURL: String)
    
    /**
     Provides a configured managed object
     */
    func configuredManagedObject(with object: NSManagedObject) -> NSManagedObject
}

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
    
    init(feedID: String, author: String, imageURL: String) {
        self.feedID = feedID
        self.author = author
        self.imageURL = imageURL
        self.tweetDescription = ""
    }
    
    /**
     Initialises object with a TWTRTweet object.
     - parameter tweet: The TWTRTweet object.
     */
    init(tweet: TWTRTweet) {
        self.init(feedID: tweet.tweetID, author: "@\(tweet.author.screenName)", imageURL: tweet.author.profileImageLargeURL)
        self.tweetDescription = tweet.text
    }
    
    /**
     Initialises object using a managed object
     */
    init?(managedObject: NSManagedObject) {
        
        guard let feedID = managedObject.value(forKey: TwitterFeedDBKey.tweetID.rawValue) as? String,
            let author = managedObject.value(forKey: TwitterFeedDBKey.author.rawValue) as? String,
            let imageURL = managedObject.value(forKey: TwitterFeedDBKey.imageURL.rawValue) as? String,
            let tweetDescription = managedObject.value(forKey: TwitterFeedDBKey.tweetDescription.rawValue) as? String else {
                return nil
        }
        
        self.init(feedID: feedID, author: author, imageURL: imageURL)
        self.tweetDescription = tweetDescription
    }
    
    func configuredManagedObject(with object: NSManagedObject) -> NSManagedObject {
        object.setValue(author, forKey: TwitterFeedDBKey.author.rawValue)
        object.setValue(imageURL, forKey: TwitterFeedDBKey.imageURL.rawValue)
        object.setValue(tweetDescription, forKey: TwitterFeedDBKey.tweetDescription.rawValue)
        
        return object
    }
}

/**
 This enum contains the type safe keys needed to communicate with CoreData
 */
enum TwitterFeedDBKey: String {
    
    /// Feed ID
    case tweetID
    
    /// Entity name
    case entityName = "TwitterFeedMO"
    
    /// Author
    case author
    
    /// Image URL
    case imageURL
    
    /// Tweet description
    case tweetDescription
}


struct GooglePlusFeed: SocialFeed {
    
    var feedID: Int
    
    var author: String
    
    var imageURL: String
    
    init(feedID: Int, author: String, imageURL: String) {
        self.feedID = feedID
        self.author = author
        self.imageURL = imageURL
    }
    
    func configuredManagedObject(with object: NSManagedObject) -> NSManagedObject {
        return object
    }
    
}
