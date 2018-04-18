//
//  DBManager.swift
//  SheddTableView
//
//  Created by Laurent Meert on 16/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/**
 A manager class for database matters.
 */
class DBManager {
    
    /// The DBManager shared instance
    static let shared = DBManager()
    
    /// The managed context of CoreData
    var managedObjectContext: NSManagedObjectContext? {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
    
    //MARK: Reusable Fetch
    
    /**
     Fetches from CoreData using an entity name and a predicate if needed.
     - parameter entity: The entity to fetch.
     - parameter predicate: A predicate to filter search results. Defaults to nil.
     - returns: The list of NSManagedObject results.
     */
    private func fetch(forEntity entity: DBEntity, predicate: NSPredicate? = nil) -> [NSManagedObject]? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        do {
            guard let fetchResults = try managedObjectContext?.fetch(fetchRequest) as? [NSManagedObject] else {
                return nil
            }
            
            return fetchResults
            
        } catch {
            print(error)
            return nil
        }
    }
    
    //MARK: Twitter
    
    /**
     Saves a twitter feed object to CoreData.
     - parameter twitterFeed: The TwitterFeed object to save.
     */
    func saveTwitterFeed(with twitterFeed: TwitterFeed) {
        
        /// Make sure we have the managed context
        guard let managedContext = managedObjectContext,
            let twitterFeedEntity = NSEntityDescription.entity(forEntityName: DBEntity.twitterFeed.rawValue, in: managedContext),
        let twitterAuthorEntity = NSEntityDescription.entity(forEntityName: DBEntity.twitterAuthor.rawValue, in: managedContext) else {
                return
        }
        
        /// Check if object already exists
        let predicate = NSPredicate(format: "\(TwitterFeedDBKey.tweetID.rawValue) == %@", twitterFeed.feedID)
        
        let twitterFeedMO: NSManagedObject
        
        if let existingObject = fetch(forEntity: .twitterFeed, predicate: predicate)?.first {
            /// We have already this object store, update it
            twitterFeedMO = existingObject
        } else {
            /// Create managed object
            twitterFeedMO = NSManagedObject(entity: twitterFeedEntity, insertInto: managedContext)
        }
        
        /// Setup managed object
        twitterFeedMO.setValue(twitterFeed.feedID, forKey: TwitterFeedDBKey.tweetID.rawValue)
        twitterFeedMO.setValue(twitterFeed.contentText, forKey: TwitterFeedDBKey.contentText.rawValue)
        
        /// Setup author for relationship
        let authorPredicate = NSPredicate(format: "\(TwitterAuthorDBKey.authorID.rawValue) == %@", twitterFeed.author.id)
        let twitterAuthorMO: NSManagedObject
        
        if let existingAuthor = fetch(forEntity: .twitterAuthor, predicate: authorPredicate)?.first {
            twitterAuthorMO = existingAuthor
        } else {
           twitterAuthorMO = NSManagedObject(entity: twitterAuthorEntity, insertInto: managedContext)
        }
        
        twitterAuthorMO.setValue(twitterFeed.author.id, forKey: TwitterAuthorDBKey.authorID.rawValue)
        twitterAuthorMO.setValue(twitterFeed.author.imageURL, forKey: TwitterAuthorDBKey.imageURL.rawValue)
        twitterAuthorMO.setValue(twitterFeed.author.name, forKey: TwitterAuthorDBKey.name.rawValue)
        twitterAuthorMO.setValue(twitterFeed.author.tagUserName, forKey: TwitterAuthorDBKey.tagUserName.rawValue)
        
        /// Set relationship
        twitterFeedMO.setValue(twitterAuthorMO, forKey: TwitterFeedDBKey.author.rawValue)
        
        /// Save managed objects
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    /**
     Fetches Twitter feeds from CoreData.
     - returns: The converted list of TwitterFeed objects.
     */
    func fetchTwitterFeeds() -> [TwitterFeed]? {
        
        guard let twitterFetchResults = fetch(forEntity: .twitterFeed) else {
            return nil
        }
        var twitterFeeds = [TwitterFeed]()
        for object in twitterFetchResults {
            if let twitterFeed = TwitterFeed(managedObject: object) {
                twitterFeeds.append(twitterFeed)
            }
        }
        
        return twitterFeeds
    }
    
    //MARK: Google Plus
    
    /**
     Saves a twitter feed object to CoreData.
     - parameter twitterFeed: The TwitterFeed object to save.
     */
    func saveGooglePlusFeed(with googlePlusFeed: GooglePlusFeed) {
        
        /// Make sure we have the managed context
        guard let managedContext = managedObjectContext,
            let googlePlusFeedEntity = NSEntityDescription.entity(forEntityName: DBEntity.googlePlusFeed.rawValue, in: managedContext),
            let googlePlusAuthorEntity = NSEntityDescription.entity(forEntityName: DBEntity.googlePlusAuthor.rawValue, in: managedContext) else {
                return
        }
        
        /// Check if object already exists
        let predicate = NSPredicate(format: "\(GooglePlusFeedDBKey.feedID.rawValue) == %@", googlePlusFeed.feedID)
        
        let googlePlusFeedMO: NSManagedObject
        
        if let existingObject = fetch(forEntity: .googlePlusFeed, predicate: predicate)?.first {
            /// We have already this object store, update it
            googlePlusFeedMO = existingObject
        } else {
            /// Create managed object
            googlePlusFeedMO = NSManagedObject(entity: googlePlusFeedEntity, insertInto: managedContext)
        }
        
        /// Setup managed object
        googlePlusFeedMO.setValue(googlePlusFeed.feedID, forKey: GooglePlusFeedDBKey.feedID.rawValue)
        googlePlusFeedMO.setValue(googlePlusFeed.contentText, forKey: GooglePlusFeedDBKey.contentText.rawValue)
        googlePlusFeedMO.setValue(googlePlusFeed.feedTitle, forKey: GooglePlusFeedDBKey.title.rawValue)
        googlePlusFeedMO.setValue(googlePlusFeed.attachmentImageURL, forKey: GooglePlusFeedDBKey.attachmentImageURL.rawValue)
        
        /// Setup author for relationship
        let authorPredicate = NSPredicate(format: "\(GooglePlusAuthorDBKey.authorID.rawValue) == %@", googlePlusFeed.author.id)
        let googlePlusAuthorMO: NSManagedObject
        
        if let existingAuthor = fetch(forEntity: .googlePlusAuthor, predicate: authorPredicate)?.first {
            googlePlusAuthorMO = existingAuthor
        } else {
            googlePlusAuthorMO = NSManagedObject(entity: googlePlusAuthorEntity, insertInto: managedContext)
        }
        
        googlePlusAuthorMO.setValue(googlePlusFeed.author.id, forKey: GooglePlusAuthorDBKey.authorID.rawValue)
        googlePlusAuthorMO.setValue(googlePlusFeed.author.imageURL, forKey: GooglePlusAuthorDBKey.imageURL.rawValue)
        googlePlusAuthorMO.setValue(googlePlusFeed.author.name, forKey: GooglePlusAuthorDBKey.name.rawValue)
        
        /// Set relationship
        googlePlusFeedMO.setValue(googlePlusAuthorMO, forKey: GooglePlusFeedDBKey.author.rawValue)
        
        /// Save managed objects
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    /**
     Fetches Twitter feeds from CoreData.
     - returns: The converted list of TwitterFeed objects.
     */
    func fetchGooglePlusFeeds() -> [GooglePlusFeed]? {
        
        guard let googlePlusFetchResults = fetch(forEntity: .googlePlusFeed) else {
            return nil
        }
        var googlePlusFeeds = [GooglePlusFeed]()
        for object in googlePlusFetchResults {
            if let googlePlusFeed = GooglePlusFeed(managedObject: object) {
                googlePlusFeeds.append(googlePlusFeed)
            }
        }
        
        return googlePlusFeeds
    }
}
