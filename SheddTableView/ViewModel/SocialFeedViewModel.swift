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
        
        APIManager.shared.fetchTweets(completion: completion)
    }
}
