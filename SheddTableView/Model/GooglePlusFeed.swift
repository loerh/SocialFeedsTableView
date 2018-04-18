//
//  GooglePlusFeed.swift
//  SheddTableView
//
//  Created by Laurent Meert on 16/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

/**
 The Google Plus feed object's structure.
 */
struct GooglePlusFeed: SocialFeed {
    
    /// Google Plus feed ID
    var feedID: String
    
    /// The feed content text
    var contentText: String
    
    /// The feed title
    let feedTitle: String
    
    /// The image URL for the content
    let attachmentImageURL: String
    
    /// The author for this feed
    let author: GooglePlusAuthor
    
    /**
     A basic initialiser.
     */
    init(feedID: String, contentText: String, feedTitle: String, attachmentImageURL: String, author: GooglePlusAuthor) {
        self.feedID = feedID
        self.contentText = contentText
        self.feedTitle = feedTitle
        self.attachmentImageURL = attachmentImageURL
        self.author = author
    }
    
    /**
     Initialises object using a managed object
     */
    init?(managedObject: NSManagedObject) {
        
        /// Find the feed fields
        guard let feedID = managedObject.value(forKey: GooglePlusFeedDBKey.feedID.rawValue) as? String,
            let contentText = managedObject.value(forKey: GooglePlusFeedDBKey.contentText.rawValue) as? String,
            let attachmentImageURL = managedObject.value(forKey: GooglePlusFeedDBKey.attachmentImageURL.rawValue) as? String,
            let title = managedObject.value(forKey: GooglePlusFeedDBKey.title.rawValue) as? String else {
                return nil
        }
        
        /// Get the author relationship
        guard let author = managedObject.value(forKey: GooglePlusFeedDBKey.author.rawValue) as? NSManagedObject else {
            return nil
        }
        
        /// Find the author fields
        guard let authorID = author.value(forKey: GooglePlusAuthorDBKey.authorID.rawValue) as? String,
            let authorName = author.value(forKey: GooglePlusAuthorDBKey.name.rawValue) as? String,
            let authorImageURL = author.value(forKey: GooglePlusAuthorDBKey.imageURL.rawValue) as? String else {
                return nil
        }
        
        /// Initialise
        let googlePlusAuthor = GooglePlusAuthor(id: authorID, name: authorName, imageURL: authorImageURL)
        
        self.init(feedID: feedID, contentText: contentText, feedTitle: title, attachmentImageURL: attachmentImageURL, author: googlePlusAuthor)
    }
    
    /**
     Parses JSON object to create a new GooglePlusFeed object.
     - parameter json: The JSON object to parse using SwiftyJSON.
     - returns: The converted GooglePlusFeed object.
     */
    static func parseJSON(with json: JSON) -> GooglePlusFeed? {
        
        guard let id = json["id"].string else {
            return nil
        }
        
        guard let title = json["title"].string else {
            return nil
        }
        
        guard let attachmentContent = json["object"]["attachments"].arrayValue.first?["content"].string else {
            return nil
        }
        
        guard let attachmentImageURL = json["object"]["attachments"].arrayValue.first?["image"]["url"].string else {
            return nil
        }
        
        guard let actor = json["actor"].dictionary else {
            return nil
        }
        
        guard let actorID = actor["id"]?.string else {
            return nil
        }
        
        guard let actorDisplayName = actor["displayName"]?.string else {
            return nil
        }
        
        guard let actorImageURL = actor["image"]?["url"].string else {
            return nil
        }
        
        let author = GooglePlusAuthor(id: actorID, name: actorDisplayName, imageURL: actorImageURL)
        
        return GooglePlusFeed(feedID: id, contentText: attachmentContent, feedTitle: title, attachmentImageURL: attachmentImageURL, author: author)
    }
    
}

/**
 This enum contains the type safe keys needed to communicate with CoreData regarding GooglePlusFeed objects.
 */
enum GooglePlusFeedDBKey: String {
    
    /// The author relationship key
    case author

    /// The feed ID key
    case feedID
    
    /// The content text key
    case contentText
    
    /// The feed title key
    case title
    
    /// The attachment image URL key
    case attachmentImageURL
}
