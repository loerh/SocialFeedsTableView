//
//  SocialFeed.swift
//  SheddTableView
//
//  Created by Laurent Meert on 15/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import CoreData

/**
 The Social Feed protocol provides guidelines for conforming classes/structs.
 */
protocol SocialFeed { 
    
    /// The feed ID
    var feedID: String { get set }
    
    /// The feed author
    var contentText: String { get set }
}
