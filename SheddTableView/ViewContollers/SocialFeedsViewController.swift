//
//  ViewController.swift
//  SheddTableView
//
//  Created by Laurent Meert on 13/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit
import GoogleSignIn

/**
 The view controller handling and displaying social feeds.
 */
class SocialFeedsViewController: UIViewController {
    
    /// The social feed table view
    @IBOutlet weak var socialFeedsTableView: SocialFeedsTableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        
        let viewModel = SocialFeedViewModel()
        
        viewModel.fetchTweets { (twitterFeeds) in
            self.socialFeedsTableView?.setup(with: twitterFeeds)
        }
    }

}

extension SocialFeedsViewController: GIDSignInUIDelegate {
    
}

