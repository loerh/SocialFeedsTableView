//
//  ViewController.swift
//  SheddTableView
//
//  Created by Laurent Meert on 13/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

/**
 The view controller handling and displaying social feeds.
 */
class SocialFeedsViewController: UIViewController {
    
    /// The social feed table view
    @IBOutlet weak var socialFeedsTableView: SocialFeedsTableView?
    
    /// The activity indicator
    @IBOutlet weak var socialFeedsActivityIndicator: UIActivityIndicatorView?
    
    /// The seach bar for feeds
    @IBOutlet weak var searchBar: UISearchBar?
    
    //MARK: App Lifecycle Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Assign search bar delegate
        searchBar?.delegate = self
        
        /// Fetch data
        socialFeedsTableView?.alpha = 0
        let viewModel = SocialFeedViewModel()
        
        viewModel.fetchTweets { (twitterFeeds) in
            
            /// Setup tableview
            self.socialFeedsTableView?.setup(with: twitterFeeds)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.socialFeedsTableView?.alpha = 1
                self.socialFeedsActivityIndicator?.alpha = 0
            }, completion: { (finished) in
                if finished {
                    self.socialFeedsActivityIndicator?.stopAnimating()
                }
            })
        }
    }

}

extension SocialFeedsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        socialFeedsTableView?.filterData()
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        socialFeedsTableView?.filterData(withKeyword: searchText)
    }
}



