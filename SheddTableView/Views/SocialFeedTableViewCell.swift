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
class SocialFeedTableViewCell: UITableViewCell, ConfigurableSocialCell {
    
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
    func configure(with data: SocialFeed) {
        feedAuthorLabel?.text = data.author
        feedImageView?.sd_setImage(with: URL(string: data.imageURL), placeholderImage: #imageLiteral(resourceName: "no_image"))
    }
    
}

/**
 The Twitter table view cell
 */
class TwitterTableViewCell: SocialFeedTableViewCell {
    
    //MARK: Other Properties
    
    /// The cell identifier
    static let identifier: String = "TwitterTableViewCell"
    
    /**
     Sets up the table view cell.
     - parameter data: The data object to use for filling the cell
     */
    override func configure(with data: SocialFeed) {
        super.configure(with: data)
        
        guard let twitterFeed = data as? TwitterFeed else {
            return
        }
        
        feedContentLabel?.text = twitterFeed.tweetDescription
    }
}

/**
 A protocol of a Social Cell that can be reused.
 */
protocol ConfigurableSocialCell {
    func configure(with data: SocialFeed)
}
