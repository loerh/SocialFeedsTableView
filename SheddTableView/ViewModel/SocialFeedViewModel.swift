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
     Fetches Feeds data for Twitter and Google Plus.
     */
    func fetch(completion: @escaping ([Any]) -> Void) {
        fetchFeeds(with: .database) { (dbFeeds) in
            completion(dbFeeds)
            
            self.fetchFeeds(with: .api, completion: { (apiFeeds) in
                completion(apiFeeds)
            })
        }
    }
    
    /**
     Fetches feeds from a specific source.
     - parameter source: The Fetch Source that needs to be used.
     */
    private func fetchFeeds(with source: FetchSource, completion: @escaping ([Any]) -> Void) {
        
        var socialFeeds = [Any]()
        
        fetchTweets(with: source) { (dbTwitterFeeds) in
            for dbTwitterFeed in dbTwitterFeeds {
                socialFeeds.append(dbTwitterFeed)
            }
            
            self.fetchGooglePlusFeeds(with: source, completion: { (dbGooglePlusFeeds) in
                for dbGooglePlusFeed in dbGooglePlusFeeds {
                    socialFeeds.append(dbGooglePlusFeed)
                    completion(socialFeeds)
                }
            })
        }
    }
    
    /**
     Fetches and persists Twitter feeds.
     - parameter source: The fetch source to use
     */
    private func fetchTweets(with source: FetchSource, completion: @escaping TwitterCompletion) {
        
        switch source {
        case .database:
            /// Show DB objects if we have some
            if let dbTwitterFeeds = DBManager.shared.fetchTwitterFeeds() {
                completion(dbTwitterFeeds)
            }
            
        case .api:
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
    
    /**
     Fetches and persists Google Plus feeds.
     */
    private func fetchGooglePlusFeeds(with source: FetchSource, completion: @escaping GooglePlusCompletion) {
        
        switch source {
        case .database:
            /// Fetch from DB
            if let googlePlusGeeds = DBManager.shared.fetchGooglePlusFeeds() {
                completion(googlePlusGeeds)
            }
            
        case .api:
            var flag = 0
            
            for userID in Constants.googlePlusIDs {
                
                APIManager.shared.fetchGooglePlusActivities(with: userID) { (apiGooglePlusFeeds) in
                    
                    for thisGooglePlusFeed in apiGooglePlusFeeds {
                        
                        DBManager.shared.saveGooglePlusFeed(with: thisGooglePlusFeed)
                        flag += 1
                        
                        if flag >= Constants.googlePlusIDs.count {
                            
                            /// Re fetch from DB
                            if let googlePlusGeeds = DBManager.shared.fetchGooglePlusFeeds() {
                                completion(googlePlusGeeds)
                            }
                        }
                    }
                }
            }
        }
    }
    
    /**
     The list of aviailable fetch sources
     */
    private enum FetchSource {
        
        /// Database source
        case database
        
        /// API source
        case api
    }
}
