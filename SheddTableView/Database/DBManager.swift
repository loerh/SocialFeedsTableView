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
    
    /**
     Saves a twitter feed object to CoreData.
     - parameter twitterFeed: The TwitterFeed object to save.
     */
    func saveTwitterFeed(with twitterFeed: TwitterFeed) {
        
        /// Make sure we have the managed context
        guard let managedContext = managedObjectContext,
            let twitterFeedEntity = NSEntityDescription.entity(forEntityName: TwitterFeedDBKey.entityName.rawValue, in: managedContext) else {
                return
        }
        
        /// Check if object already exists
        let predicate = NSPredicate(format: "\(TwitterFeedDBKey.tweetID.rawValue) == %@", twitterFeed.feedID)
        let twitterFeedMO: NSManagedObject
        if let existingObject = fetchTwitterFeeds(predicate: predicate)?.first {
            /// We have already this object store, update it
            twitterFeedMO = existingObject
        } else {
            /// Create managed object
            twitterFeedMO = NSManagedObject(entity: twitterFeedEntity, insertInto: managedContext)
        }
        
        /// Setup managed object
        twitterFeedMO.setValue(twitterFeed.feedID, forKey: TwitterFeedDBKey.tweetID.rawValue)
        twitterFeedMO.setValue(twitterFeed.author, forKey: TwitterFeedDBKey.author.rawValue)
        twitterFeedMO.setValue(twitterFeed.imageURL, forKey: TwitterFeedDBKey.imageURL.rawValue)
        twitterFeedMO.setValue(twitterFeed.tweetDescription, forKey: TwitterFeedDBKey.tweetDescription.rawValue)
        
        /// Save managed object
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    func fetchTwitterFeeds(predicate: NSPredicate? = nil) -> [TwitterFeed]? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TwitterFeedDBKey.entityName.rawValue)
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        do {
            guard let fetchResults = try managedObjectContext?.fetch(fetchRequest) as? [NSManagedObject] else {
                return nil
            }
            
            var twitterFeeds = [TwitterFeed]()
            for object in fetchResults {
                if let twitterFeed = TwitterFeed(managedObject: object) {
                    twitterFeeds.append(twitterFeed)
                }
            }
            
            return twitterFeeds
            
        } catch {
            print(error)
            return nil
        }
    }
}
