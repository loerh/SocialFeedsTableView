//
//  SocialFeedTableViewCell.swift
//  SheddTableView
//
//  Created by Laurent Meert on 15/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

/**
 The table view cell that displays a social feed's metadata.
 */
class SocialFeedTableViewCell: UITableViewCell {
    
    //MARK: Outlet Properties
    
    /// The feed image view
    @IBOutlet weak var feedImageView: UIImageView?
    
    /// The feed author
    @IBOutlet weak var feedAuthorLabel: UILabel?

    /// The feed description/main content
    @IBOutlet weak var feedContentLabel: UILabel?
    
    /**
     Sets up the table view cell.
     - parameter data: The data object to use for filling the cell
     */
    func configure(withFeed feed: SocialFeed) {
        feedAuthorLabel?.text = feed.author
        feedImageView?.sd_setImage(with: URL(string: feed.imageURL), placeholderImage: #imageLiteral(resourceName: "no_image"))
    }
    
}

/**
 The Twitter table view cell
 */
class TwitterTableViewCell: SocialFeedTableViewCell, ConfigurableSocialCell {
    
    //MARK: Other Properties
    
    /// The cell identifier
    static let identifier: String = "TwitterTableViewCell"
    
    /**
     Sets up the table view cell.
     - parameter data: The data object to use for filling the cell
     */
    func configure(with twitterFeed: TwitterFeed) {
        configure(withFeed: twitterFeed)
        feedContentLabel?.text = twitterFeed.tweetDescription
    }
}

class GoogleTableViewCell: SocialFeedTableViewCell, ConfigurableSocialCell {
    
    //MARK: Other Properties
    
    /// The cell identifier
    static let identifier: String = "TwitterTableViewCell"
    
    //MARK: Protocol Config
    
    
    func configure(with googleFeed: GooglePlusFeed) {
        configure(withFeed: googleFeed)
        
    }
}

/**
 A protocol of a Social Cell that can be reused.
 */
protocol ConfigurableSocialCell {
    associatedtype SocialFeedData
    func configure(with feed: SocialFeedData)
}
