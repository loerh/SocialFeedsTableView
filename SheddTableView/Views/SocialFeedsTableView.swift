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
        return data?.count ?? 0
    }
}

extension SocialFeedsTableView: UITableViewDelegate {
    
}
