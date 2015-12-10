//
//  SearchController.swift
//  BamBox
//
//  Created by Phil Cole on 11/11/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class SearchController: NSObject, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var searchResults:[AnyObject] = []
    var containerView:UIView!
    var searchResultsTableview:UITableView!
    var searchResultsViewController:UIViewController!
    var searchController:UISearchController!
    var searchBarConstraints:[NSLayoutConstraint] = [NSLayoutConstraint]()
    var searchBarContainer:UIView!
    var embeddedViewController:UIViewController!
    let cellId:String = "Cell"
    var trackArray:[SPTPartialTrack] = [SPTPartialTrack]()
    var playlist:Playlist!
    override init() {
        super.init()
    }
    
    
    init(searchBarContainerView:UIView, viewController:UIViewController, playlist:Playlist) {
        super.init()
        self.playlist = playlist
        embeddedViewController = viewController
        searchBarContainer = searchBarContainerView
        
        setupTableView(viewController)
        
        initSearchResultsViewController()
        
        initSearchController()
        
        // Enable Presentation Context
        viewController.definesPresentationContext = true
    
        setupSearchBar(searchBarContainerView)
    }
    
    func setupTableView(viewController:UIViewController) {
        // Setup the table View
        searchResultsTableview = UITableView(frame: viewController.view.frame, style: UITableViewStyle.Plain)
        searchResultsTableview.dataSource = self;
        searchResultsTableview.delegate = self;
        searchResultsTableview.estimatedRowHeight = 45
        searchResultsTableview.rowHeight = UITableViewAutomaticDimension
        // Register the work order list cell
        searchResultsTableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellId)

    }
    
    func initSearchResultsViewController() {
        // Init a search result view controller and add the table view as subview
        searchResultsViewController = UIViewController()
        searchResultsViewController.view.addSubview(searchResultsTableview)
        searchResultsTableview.translatesAutoresizingMaskIntoConstraints = false
        
        // Create the constraints for the tableview, NSLayoutConstraints returns an array of constraints
        let tableViewDict:Dictionary = ["tableView":searchResultsTableview]
        var tableViewConstraints = [NSLayoutConstraint]()
        tableViewConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options:[] , metrics: nil, views: tableViewDict)
        tableViewConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options:[] , metrics: nil, views: tableViewDict)
        
        searchResultsViewController.view.addConstraints(tableViewConstraints)
    }
    
    func initSearchController() {
        // Init a search controller with its view controller for results
        searchController = UISearchController(searchResultsController: searchResultsViewController)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.text = ""
    }
    
    func setupSearchBar(searchBarContainerView:UIView) {
        // add the search bar to the container view
        searchBarContainerView.addSubview(searchController.searchBar)
        
        // Turn off autoresizing mask so we can apply contraints manually
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the search bar to a dictionary to apply constraints
        let searchBarDict:Dictionary = ["searchBar":searchController.searchBar]
        
        // NSLayoutConstraint returns an array of constraints, add them to an array
        searchBarConstraints = [NSLayoutConstraint]()
        searchBarConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[searchBar]|", options: [], metrics: nil, views: searchBarDict)
        searchBarConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[searchBar]|", options: [], metrics: nil, views: searchBarDict)
        searchBarContainerView.addConstraints(searchBarConstraints)
        
        // set the searchBar delegate to self
        searchController.searchBar.delegate = self
    }
}
// MARK: - TableViewDataSource
extension SearchController {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trackArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if self.trackArray.count == 0 {
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
            cell.textLabel?.text = "No Results"
            return cell
        } else {
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
            let partialTrack = self.trackArray[indexPath.row]
            cell.textLabel?.text = partialTrack.name
            return cell
        }
    }
}

// MARK: - TableViewDelegate
extension SearchController {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.playlist.addTrackToPlaylist(self.trackArray[indexPath.row], completion: { (bool) -> Void in
            if bool {
                NavRouter.router().popViewController(true)
            }
        })
    }
}
// MARK: - UISearchResultsDelegate
extension SearchController {
    /*
    Called when the search bar's text or scope has changed or when the search bar becomes first responder.
    *NOTE* For now ask the data handler to provide search results for the work order id.
    We will update this at a later time
    */
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        SpotifyService.singleton.searchSpotifyLibrary(searchController.searchBar.text!) { (results:[SPTPartialTrack]) -> Void in
            self.trackArray = results
            self.searchResultsTableview.reloadData()
        }
    }
}

extension SearchController {
    
    
    //    Need to turn back on autoresizing mask to let the OS handle the transition effects
    func willPresentSearchController(searchController: UISearchController) {
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchBarContainer.removeConstraints(searchBarConstraints)
    }
    
    //    Turn autoresizing mask off so we can apply constraints
    func didDismissSearchController(searchController: UISearchController) {
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBarContainer.addConstraints(searchBarConstraints)
    }
}


// MARK: - UISearchBarDelegate
extension SearchController {
    //    Could implement a method to make it go
    // fetch all objects from core data and not let it assign the one the user clicked
    // if it is not found in the current array of objects from the backend
    // would be used for equipment, assigne, buildings, etc
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
    }
    
}
