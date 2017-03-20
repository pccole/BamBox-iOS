//
//  TrackListViewModel.swift
//  BamBox
//
//  Created by Phil Cole on 3/9/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class TracksListViewModel: NSObject, ListViewModel {
	
	private let partialPlaylist:SPTPartialPlaylist
	
	var runable: ListRunable? {
		return self.getTracks
	}
	
	var delegate: ListViewDelegate? {
		return self
	}
	
	var dataSource: ListViewDataSource? {
		return self
	}
	
	var title: String {
		get {
			return self.partialPlaylist.name
		}
	}
	
	init(playlist:SPTPartialPlaylist) {
		partialPlaylist = playlist
		super.init()
	}
	
	func viewDidLoad(_ vc: UIViewController) {
		
	}
	
	func getTracks(_ listItemCallback:@escaping ListItemCallback) {
		sptService.getTracks(for: self.partialPlaylist, listItemCallback: listItemCallback)
	}
}

extension TracksListViewModel: ListViewDelegate {
	func listView(_ listView: UITableView, didSelect listItem: ListItem, at indexPath: IndexPath) {
		// play song
	}
}

extension TracksListViewModel: ListViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
}
