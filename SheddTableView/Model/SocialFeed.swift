//
//  SocialFeed.swift
//  SheddTableView
//
//  Created by Laurent Meert on 15/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import TwitterKit

protocol SocialFeed {
    var author: String {get set}
    var imageURL: String {get set}
    init(author: String, imageURL: String)
}

struct TwitterFeed: SocialFeed {
    
    var author: String
    
    var imageURL: String
    
    var tweetDescription: String
    
    init(author: String, imageURL: String) {
        self.author = author
        self.imageURL = imageURL
        self.tweetDescription = ""
    }
    
    init(tweet: TWTRTweet) {
        self.init(author: tweet.author.name, imageURL: tweet.author.profileImageURL)
        self.tweetDescription = tweet.text
    }
}
