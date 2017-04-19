//
//  NearbyScanViewController.swift
//  BamBox
//
//  Created by Phil Cole on 3/19/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit
import AlamofireImage

class NearbyScanViewController: BaseViewController {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var playlistTitle: UILabel!
	
	var playlist:SPTPartialPlaylist?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		nearby.scan()
		nearby.playlistDelegate = self
		let tap = UITapGestureRecognizer(target: self, action: #selector(albumTapped(_:)))
		imageView.addGestureRecognizer(tap)
    }

	static func show() {
		navRouter.pushViewController(NearbyScanViewController())
	}
	
	@objc private func albumTapped(_ recognizer:UITapGestureRecognizer) {
		guard let p = playlist else { return }
		ListViewController.show(viewModel: TracksListViewModel(playlist: p))
	}
}

extension NearbyScanViewController: NearbyPlaylistProtocol {
	func didRetrive(_ playlist: SPTPartialPlaylist) {
		self.playlist = playlist
		playlistTitle.text = playlist.displayHeader
		guard let url = playlist.displayImageURL else { return }
		imageView.af_setImage(withURL: url)
	}
}
