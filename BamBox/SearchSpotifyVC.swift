//
//  SearchSpotifyVC.swift
//  BamBox
//
//  Created by Phil Cole on 11/11/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class SearchSpotifyVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet internal weak var tableView: UITableView!
    @IBOutlet weak var searchBarView: UIView!
    
    var playlist:Playlist!
    var searchBarConstraints = [NSLayoutConstraint]()
    var trackArray = [SPTPartialTrack]()
    var searchController:SearchController!
    
    let cellId:String = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.searchController = SearchController(searchBarContainerView: searchBarView, viewController: self, playlist: self.playlist)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - TableViewDataSource
extension SearchSpotifyVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trackArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.trackArray.count == 0 {
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            cell.textLabel?.text = "No Results"
            return cell
        } else {
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            let partialTrack = self.trackArray[indexPath.row]
            cell.textLabel?.text = partialTrack.name
            return cell
        }
    }
}

// MARK: - TableViewDelegate
extension SearchSpotifyVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.playlist.addTrackToPlaylist(self.trackArray[indexPath.row]) { (bool) -> Void in
            if bool {
                NavRouter.router().popViewController(true)
            } else {
                print("error adding song to playlist")
            }
        }
    }
}

// MARK: - UISearchResultsDelegate
extension SearchSpotifyVC {
    /*
    Called when the search bar's text or scope has changed or when the search bar becomes first responder.
    *NOTE* For now ask the data handler to provide search results for the work order id.
    We will update this at a later time
    */
    func updateSearchResults(for searchController: UISearchController) {
        SpotifyService.singleton.searchSpotifyLibrary(searchController.searchBar.text!) { (results:[SPTPartialTrack]) -> Void in
            self.trackArray = results
            self.tableView.reloadData()
        }
    }
}

extension SearchSpotifyVC {
    //    Need to turn back on autoresizing mask to let the OS handle the transition effects
    func willPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchBarView.removeConstraints(searchBarConstraints)
    }
    
    //    Turn autoresizing mask off so we can apply constraints
    func didDismissSearchController(_ searchController: UISearchController) {
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.addConstraints(searchBarConstraints)
    }
}


// MARK: - UISearchBarDelegate
extension SearchSpotifyVC {
    // Could implement a method to make it go
    // fetch all objects from core data and not let it assign the one the user clicked
    // if it is not found in the current array of objects from the backend
    // would be used for equipment, assigne, buildings, etc
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}
