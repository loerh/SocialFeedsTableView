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
    
    /// The list of Instagram IDs
    static let instagramIDs = [""]
    
    /// The Twitter consumer key
    static let twitterConsumerKey = "aVelmUV8hQUpkaXddREspxSOq"
    
    /// The Twitter consumer secret
    static let twitterConsumerSecret = "3cShAxyPMD160JdPhhUG4qUiDL4497QcsIWVC8hMaSY6AjZrmC"
    
    /// The Instagram client ID
    static let instagramClientID = "a8abc5be53f14a76ad7a371b46ab2b6b"
    
    /// The Google SignIn client ID
    static let googleSignInClientID = "637614579430-pe7kibfpn9f8l299h2b6vapqinuii7f5.apps.googleusercontent.com"
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

/// A type alias for the twitter completion
typealias TwitterCompletion = ([TwitterFeed]) -> Void
