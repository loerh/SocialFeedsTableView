//
//  SocialFeedTableView.swift
//  SheddTableView
//
//  Created by Laurent Meert on 15/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import UIKit

/**
 A custom and reusable table view that displays a list of cells.
 */
class SocialFeedsTableView: UITableView {
    
    //MARK: Private properties
    
    /// The array of data to display in the table view
    private var data: [Any]?
    
    //MARK: Setup
    
    /**
     Sets up the tableview.
     - parameter data: The data to assign and display for this table view.
     */
    func setup(with data: [Any]) {
        self.delegate = self
        self.dataSource = self
        self.data = data
        reloadData()
    }
}

extension SocialFeedsTableView: UITableViewDataSource {
    
    //MARK: Datasource Functions
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TwitterTableViewCell.identifier) as? TwitterTableViewCell else {
            return UITableViewCell()
        }
        
        if let feed = data?[indexPath.row] as? TwitterFeed {
            cell.configure(with: feed)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return data?.flatMap({ $0 as? TwitterFeed }).count ?? 0
        case 1: return 0
        default: return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data?.count ?? 0 == 0 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Twitter Feeds"
        case 1: return "Instagram Feeds"
        default: return nil
        }
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
