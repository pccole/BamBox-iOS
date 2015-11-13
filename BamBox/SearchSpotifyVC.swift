//
//  SearchSpotifyVC.swift
//  BamBox
//
//  Created by Phil Cole on 11/11/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class SearchSpotifyVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var searchResultsController:UITableViewController!
    var searchController:UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - TableViewDataSource
extension SearchSpotifyVC {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        return cell
    }
}

// MARK: - TableViewDelegate
extension SearchSpotifyVC {
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        self.searchResultsController = UITableViewController(style: UITableViewStyle.Plain)
        self.searchResultsController.tableView.delegate = self
        self.searchResultsController.tableView.dataSource = self
        searchController = UISearchController(searchResultsController: searchResultsController)
//        searchController.delegate = self
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self

        searchController.searchBar.sizeToFit()
        
        return searchController.searchBar
    }
}