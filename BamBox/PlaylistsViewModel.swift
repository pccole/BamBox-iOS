//
//  PlaylistViewModel.swift
//  BamBox
//
//  Created by Phil Cole on 3/9/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation

class PlaylistViewModel: NSObject, ListViewModel {
	
	var title: String {
		return "Playlist"
	}
	
	var runable: ListRunable {
		return sptService.getAllPlaylist
	}
	
	func registerCell(with tableView: UITableView) {
		let nib = UINib(nibName: PlaylistTableViewCell.identifier, bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: PlaylistTableViewCell.identifier)
	}
	
	func listView(_ tableView: UITableView, item listItem: ListItem, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier, for: indexPath) as? PlaylistTableViewCell,
			let playlist = listItem as? SPTPartialPlaylist else {
			return UITableViewCell()
		}
		cell.configure(for: playlist)
		cell.backgroundColor = UIColor.clear
		return cell
	}
}
