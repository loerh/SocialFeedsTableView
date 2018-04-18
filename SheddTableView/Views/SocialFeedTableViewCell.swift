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
        feedAuthorLabel?.text = twitterFeed.author.name
        feedImageView?.sd_setImage(with: URL(string: twitterFeed.author.imageURL), placeholderImage: #imageLiteral(resourceName: "no_image"))
        feedAuthorLabel?.text = twitterFeed.author.tagUserName
        feedContentLabel?.text = twitterFeed.contentText
    }
}

class GoogleTableViewCell: SocialFeedTableViewCell, ConfigurableSocialCell {
    
    //MARK: Other Properties
    
    /// The cell identifier
    static let identifier: String = "GoogleTableViewCell"
    
    //MARK: Protocol Config
    
    
    func configure(with googleFeed: GooglePlusFeed) {
        
        feedAuthorLabel?.text = googleFeed.author.name
        feedImageView?.sd_setImage(with: URL(string: googleFeed.author.imageURL), placeholderImage: #imageLiteral(resourceName: "no_image"))
        feedContentLabel?.text = googleFeed.contentText
    }
}

/**
 A protocol of a Social Cell that can be reused.
 */
protocol ConfigurableSocialCell {
    associatedtype SocialFeedData
    func configure(with feed: SocialFeedData)
}
