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
    static let twitterIDs = ["981097027391098880", "971689430229626880"]
    
    /// The list of Instagram IDs
    static let instagramIDs = [""]
}

/// A type alias for the twitter completion
typealias TwitterCompletion = ([TwitterFeed]) -> Void
