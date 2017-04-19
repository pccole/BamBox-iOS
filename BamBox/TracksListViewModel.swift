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
	
	private var tableView:UITableView?
	
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
	
	func viewDidLoad(_ vc: ListViewController) {
		tableView = vc.tableView
	}
	
	func getTracks(_ listItemCallback:@escaping ListItemCallback) {
		sptService.getTracks(for: self.partialPlaylist, listItemCallback: listItemCallback)
	}
}

extension TracksListViewModel: ListViewDelegate { }

extension TracksListViewModel: ListViewDataSource {
	func listView(_ listView: UITableView, didSelect listItem: ListItem, at indexPath: IndexPath) {
		listView.deselectRow(at: indexPath, animated: true)
//		let notification = Notification(name: Notification.Name(rawValue: "Play"), object: nil, userInfo: ["Track":listItem])
//		NotificationCenter.default.post(notification)
		guard let track = listItem as? SPTTrack else {
			return
		}
//		SpotifyPlayer.play(track: track)
	}
}
