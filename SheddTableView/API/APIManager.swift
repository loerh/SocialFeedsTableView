//
//  APIManager.swift
//  SheddTableView
//
//  Created by Laurent Meert on 15/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import TwitterCore
import TwitterKit
import SwiftyJSON
import Alamofire


/**
 A manager for API calls.
 */
class APIManager {
    
    /// The API manager shared instance
    static let shared = APIManager()
    
    /**
     Fetches tweets using TwitterKit.
     - parameter tweetIDs: The list of tweet ids to fetch.
     */
    func fetchTweets(withIDs tweetIDs: [String] = Constants.twitterIDs,
                     completion: @escaping TwitterCompletion) {
        
        /// Create a twitter client
        let client = TWTRAPIClient()
        
        /// Fetch tweets
        client.loadTweets(withIDs: tweetIDs) { (apiTweets, error) in
            guard let apiTweets = apiTweets else {
                print(String(describing: error))
                return
            }
            
            /// Convert to TwitterFeed objects.
            var twitterFeeds = [TwitterFeed]()
            
            for thisTweet in apiTweets {
                let twitterFeed = TwitterFeed(tweet: thisTweet)
                twitterFeeds.append(twitterFeed)
            }
            
            completion(twitterFeeds)
        }
    }
}
