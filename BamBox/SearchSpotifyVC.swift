//
//  SearchSpotifyVC.swift
//  BamBox
//
//  Created by Phil Cole on 11/11/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class SearchSpotifyVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet internal weak var tableView: UITableView!
    @IBOutlet weak var searchBarView: UIView!
    
    var searchController:SearchController!
    var playlist:Playlist!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchController = SearchController(searchBarContainerView: self.searchBarView, viewController: self, playlist: self.playlist)
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

}