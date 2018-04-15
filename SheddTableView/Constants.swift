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
}

/// A type alias for the twitter completion
typealias TwitterCompletion = ([TwitterFeed]) -> Void
