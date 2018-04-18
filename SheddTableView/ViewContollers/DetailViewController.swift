//
//  DetailViewController.swift
//  SheddTableView
//
//  Created by Laurent Meert on 15/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import UIKit

/**
 The detail view controller showing more info about the selected feed.
 */
class DetailViewController: UIViewController {
    
    //MARK: Oulets Properties
    
    /// The image view of feed author
    @IBOutlet weak var feedAuthorImageView: UIImageView?
    
    /// The author username label
    @IBOutlet weak var feedAuthorUsernameLabel: UILabel?
    
    /// The author name label
    @IBOutlet weak var feedAuthorLabel: UILabel?
    
    /// The feed author description label
    @IBOutlet weak var feedAuthorDescription: UILabel?
    
    /// The image view for the feed, if any
    @IBOutlet weak var feedContentImageView: UIImageView?
    
    /// The height constraint for feed content image view
    @IBOutlet weak var feedContentImageHeightConstraint: NSLayoutConstraint?
    
    //MARK: Other Properties
    
    /// The feed object
    private var feed: SocialFeed?
    
    /// The identifier
    static let storyboardIdentifier = "DetailViewController"
    
    //MARK: App Lifecyle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedContentImageView?.isHidden = true
        if let feed = feed {
            configureOutlets(with: feed)
        }
    }
    
    //MARK: Functions
    
    /**
     Closes/Dismisses the view controller.
     */
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    /**
     Configures outlets for the view controller.
     - parameter feed: The SocialFeed generic object to configure the outlets.
     */
    private func configureOutlets(with feed: SocialFeed) {
        feedAuthorDescription?.text = feed.contentText
        
        if let twitterFeed = feed as? TwitterFeed {
            feedAuthorImageView?.sd_setImage(with: URL(string: twitterFeed.author.imageURL), placeholderImage: #imageLiteral(resourceName: "no_image"))
            feedAuthorLabel?.text = twitterFeed.author.name
            feedAuthorUsernameLabel?.text = twitterFeed.author.tagUserName
            feedContentImageHeightConstraint?.constant = 0
        } else if let googlePlusFeed = feed as? GooglePlusFeed {
            feedAuthorImageView?.sd_setImage(with: URL(string: googlePlusFeed.author.imageURL), placeholderImage: #imageLiteral(resourceName: "no_image"))
            feedAuthorLabel?.text = googlePlusFeed.author.name
            feedAuthorUsernameLabel?.text = googlePlusFeed.feedTitle
            feedContentImageView?.sd_setImage(with: URL(string: googlePlusFeed.attachmentImageURL), placeholderImage: #imageLiteral(resourceName: "no_image"))
            feedContentImageView?.isHidden = false
        }
    }
    
    /**
     Configures the view controller.
     - parameter feed: The SocialFeed generic object to configure the outlets.
     */
    func configure(with feed: SocialFeed) {
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        self.feed = feed
    }
}

extension DetailViewController: UIViewControllerAnimatedTransitioning {
    
    //MARK: UIViewControllerAnimatedTransitioning Functions
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}
