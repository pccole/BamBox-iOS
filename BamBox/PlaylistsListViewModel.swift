//
//  PlaylistViewModel.swift
//  BamBox
//
//  Created by Phil Cole on 3/9/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation
import UIKit

class PlaylistsListViewModel: NSObject, ListViewModel {
	
	var title: String {
		return "Playlists"
	}
	
	var runable: ListRunable? {
		return sptService.getAllPlaylist
	}
	
	var dataSource: ListViewDataSource? {
		return self
	}
	
	var delegate: ListViewDelegate? {
		return self
	}
	
	func viewDidLoad(_ vc: ListViewController) {
		guard let startImage = UIImage(named: "StartPlaylist") else {
			return
		}
		let rightButton = UIBarButtonItem(image: startImage, style: UIBarButtonItemStyle.done, target: self, action: #selector(createNewPlaylist))
		navRouter.navController.navigationItem.rightBarButtonItem = rightButton
	}
	
	func createNewPlaylist() {
		CreateBamBoxViewController.show()
	}
	
}

extension PlaylistsListViewModel: ListViewDataSource { }

extension PlaylistsListViewModel: ListViewDelegate {
	func listView(_ listView: UITableView, didSelect listItem: ListItem, at indexPath: IndexPath) {
		listView.deselectRow(at: indexPath, animated: true)
		guard let playlist = listItem as? SPTPartialPlaylist else {
			return
		}
		ListViewController.show(viewModel: StartBamBoxViewModel(playlist: playlist))
	}
}

