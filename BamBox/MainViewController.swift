//
//  MainViewController.swift
//  BamBox
//
//  Created by Phil Cole on 2/19/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit

class MainViewController: BamBoxViewController {

	override class func show() {
		navRouter.setMainViewController(MainViewController())
		navRouter.isNavigationBarHidden = true
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		sptService.getUser(userCallback: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	@IBAction func createPlaylistTapped(_ sender: UIButton) {
		guard sptService.isValidSession else {
			LoginViewController.show() {
				let playlist = PlaylistViewController(title: "Playlists", playlistRunable: sptService.getAllPlaylist)
				navRouter.setViewControllers([MainViewController(), playlist], animated: true)
				navRouter.isNavigationBarHidden = false
			}
			return
		}
		PlaylistViewController.show(title: "Playlists", playlistRunable: sptService.getAllPlaylist)
	}
	
	@IBAction func scanForBamBox(_ sender: UIButton) {
		guard sptService.isValidSession else {
			LoginViewController.show() {
				navRouter.setViewControllers([MainViewController(), ScanBamBoxViewController()], animated: true)
				navRouter.isNavigationBarHidden = false
			}
			return
		}
		ScanBamBoxViewController.show()
	}
}
