//
//  Author.swift
//  SheddTableView
//
//  Created by Laurent Meert on 18/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation

/**
 The Author protocol provides guidelines for conforming classes/structs.
 */
protocol Author {
    
    /// Author ID
    var id: String { get set }
    
    /// Author name
    var name: String { get set }
    
    /// Author image URL
    var imageURL: String { get set }
}

/**
 The Twitter author struct.
 */
struct TwitterAuthor: Author {
    
    /// Author ID
    var id: String
    
    /// Author name
    var name: String
    
    /// Author image URL
    var imageURL: String
    
    /// Author tag user name ("@")
    let tagUserName: String
    
}

/**
 The list of keys for CoreData Twitter author managed object
 */
enum TwitterAuthorDBKey: String {
    
    /// The author ID
    case authorID
    
    /// Image URL
    case imageURL
    
    /// Twitter "@" tagged username
    case tagUserName
    
    /// The display name of author
    case name
}

/**
 The Google Plus author struct.
 */
struct GooglePlusAuthor: Author {
    
    /// Author ID
    var id: String
    
    /// Author name
    var name: String
    
    /// Author image URL
    var imageURL: String
}

/**
 The list of keys for CoreData Google Plus author managed object.
 */
enum GooglePlusAuthorDBKey: String {
        
    /// The author ID
    case authorID
    
    /// Image URL
    case imageURL
    
    /// The display name of author
    case name
}

