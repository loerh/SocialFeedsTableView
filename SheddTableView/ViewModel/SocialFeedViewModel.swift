//
//  SocialFeedViewModel.swift
//  SheddTableView
//
//  Created by Laurent Meert on 15/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation

/**
 The view model for Social Feed.
 */
class SocialFeedViewModel {
    
    /**
     Fetches and persists twitter feeds.
     */
    func fetchTweets(completion: @escaping TwitterCompletion) {
        
        /// Show DB objects if we have some
        if let dbTwitterFeeds = DBManager.shared.fetchTwitterFeeds() {
            completion(dbTwitterFeeds)
        }
        
        /// Fetch from API to update with fresh data
        APIManager.shared.fetchTweets() { (twitterFeeds) in
            for twitterFeed in twitterFeeds {
                DBManager.shared.saveTwitterFeed(with: twitterFeed)
            }
            
            /// Refetch from DB after updates
            if let dbTwitterFeeds = DBManager.shared.fetchTwitterFeeds() {
                completion(dbTwitterFeeds)
            }
        }
    }
}
