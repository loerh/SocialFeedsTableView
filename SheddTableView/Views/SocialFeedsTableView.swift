//
//  SocialFeedTableView.swift
//  SheddTableView
//
//  Created by Laurent Meert on 15/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

/**
 A custom and reusable table view that displays a list of cells.
 */
class SocialFeedsTableView: UITableView {
    
    //MARK: Private properties
    
    /// The array of data to display in the table view
    private var data: [Any]?
    
    private var initialData: [Any]?
    
    //MARK: Setup
    
    /**
     Sets up the tableview.
     - parameter data: The data to assign and display for this table view.
     */
    func setup(with data: [Any]) {
        self.delegate = self
        self.dataSource = self
        self.data = data
        self.initialData = data
        reloadData()
    }
    
    func filterData(withKeyword keyword: String? = nil) {
        
        guard let keyword = keyword?.lowercased(),
            !keyword.isEmpty else {
            self.data = initialData
            reloadData()
            return
        }
        
        let newData = self.initialData?.filter {
            
            if let twitterFeed = $0 as? TwitterFeed {
                
                return twitterFeed.author.lowercased().contains(keyword) || twitterFeed.feedID.contains(keyword) || twitterFeed.tweetDescription.lowercased().contains(keyword) || twitterFeed.tagUsername.lowercased().contains(keyword)
            } else if let googleFeed = $0 as? GooglePlusFeed {
                
                return googleFeed.author.lowercased().contains(keyword) || googleFeed.feedID.contains(keyword)
            }
            
            return false
        }
        
        self.data = newData
        
        reloadData()
    }
}

extension SocialFeedsTableView: UITableViewDataSource {
    
    //MARK: Datasource Functions
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TwitterTableViewCell.identifier) as? TwitterTableViewCell else {
            return UITableViewCell()
        }
        
        if let feed = data?[indexPath.row] as? TwitterFeed {
            cell.configure(with: feed)
        }
        
        return cell
            
        case 1:
            
            if GIDSignIn.sharedInstance().currentUser != nil {
            
                guard let cell = tableView.dequeueReusableCell(withIdentifier: GoogleTableViewCell.identifier) as? GoogleTableViewCell else {
                    return UITableViewCell()
                }
                
                if let googleFeed = data?[indexPath.row] as? GooglePlusFeed {
                    cell.configure(with: googleFeed)
                }
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: GoogleSignInTableViewCell.identifier) as? GoogleSignInTableViewCell else {
                    return UITableViewCell()
                }
                
                return cell
            }
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return data?.flatMap({ $0 as? TwitterFeed }).count ?? 0
        case 1:
            return GIDSignIn.sharedInstance().currentUser != nil ? data?.flatMap({ $0 as? GooglePlusFeed }).count ?? 0 : 1
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data?.count ?? 0 == 0 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Twitter Feeds"
        case 1: return "Google Plus Feeds"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 1 && GIDSignIn.sharedInstance().currentUser == nil ? 95 : 75
    }
}

extension SocialFeedsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        deselectRow(at: indexPath, animated: true)
        
        guard let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailViewController.storyboardIdentifier) as? DetailViewController,
            let feed = data?[indexPath.row] as? TwitterFeed else {
            return
        }

        detailsVC.configure(with: feed)
        UIApplication.topViewController()?.present(detailsVC, animated: true, completion: nil)
    }
}
