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
    
    /// Twitter ID
    var feedID: String
    
    /// Twitter author
    var author: String
    
    /// Twitter image URL
    var imageURL: String
    
    let attachmentImageURL: String
    
    let attachmentContent: String
    
    init(feedID: String, author: String, imageURL: String, attachmentImageURL: String, attachmentContent: String) {
        self.feedID = feedID
        self.author = author
        self.imageURL = imageURL
        self.attachmentImageURL = attachmentImageURL
        self.attachmentContent = attachmentContent
    }
    
    static func parseJSON(with json: JSON) -> GooglePlusFeed? {
        
        guard let id = json["id"].string else {
            return nil
        }
        
        guard let title = json["title"].string else {
            return nil
        }
        
        guard let attachmentContent = json["attachments"].arrayValue.first?["content"].string else {
            return nil
        }
        
        guard let attachmentImageURL = json["attachments"].arrayValue.first?["image"]["url"].string else {
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
        
        return GooglePlusFeed(feedID: id, author: actorDisplayName, imageURL: actorImageURL, attachmentImageURL: attachmentImageURL, attachmentContent: attachmentContent)
    }
    
}
