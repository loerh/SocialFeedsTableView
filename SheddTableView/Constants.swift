//
//  Constants.swift
//  SheddTableView
//
//  Created by Laurent Meert on 15/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation

/**
 Contains the list of application's general constants
 */
struct Constants {
    
    /// The list of twitter IDs
    static let twitterIDs = ["981097027391098880", "971689430229626880", "984862281312776192", "985289170573668352", "985254902464118785"]
    
    /// The list of Google Plus IDs
    static let googlePlusIDs = ["+TechCrunch"]
    
    static let googleAPIKey = "AIzaSyA5hNQN5RpVaD5sjqWDwO3LX8lSDcwQhMY"
    
    /// The Twitter consumer key
    static let twitterConsumerKey = "aVelmUV8hQUpkaXddREspxSOq"
    
    /// The Twitter consumer secret
    static let twitterConsumerSecret = "3cShAxyPMD160JdPhhUG4qUiDL4497QcsIWVC8hMaSY6AjZrmC"
    
}

/**
 The list of Core Data entity names
 */
enum DBEntity: String {
    
    /// Twitter entity name
    case twitter = "TwitterFeedMO"
    
    /// Google Plus entity name
    case googlePlus = "GooglePlusFeedMO"
}

/// A type alias for the Twitter completion
typealias TwitterCompletion = ([TwitterFeed]) -> Void

/// A type alias for the Google Plus completion
typealias GooglePlusCompletion = ([GooglePlusFeed]) -> Void
