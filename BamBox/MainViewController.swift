//
//  MainViewController.swift
//  BamBox
//
//  Created by Phil Cole on 2/19/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

	static func show() {
		navRouter.setMainViewController(MainViewController())
		navRouter.isNavigationBarHidden = true
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		sptService.getUser(userCallback: nil)
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		navRouter.isNavigationBarHidden = true
		nearby.reset()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	@IBAction func createPlaylistTapped(_ sender: UIButton) {
//		nearby.scan()
		nearby.isBroadCaster = true
		guard sptService.isValidSession else {
			LoginViewController.show() {
				let playlist = ListViewController(viewModel: PlaylistsListViewModel())
				navRouter.setViewControllers([MainViewController(), playlist], animated: true)
			}
			return
		}
		ListViewController.show(viewModel: PlaylistsListViewModel())
	}
	
	@IBAction func scanForBamBox(_ sender: UIButton) {
		nearby.isClient = true
		guard sptService.isValidSession else {
			LoginViewController.show() {
				navRouter.setViewControllers([MainViewController(), NearbyScanViewController()], animated: true)
			}
			return
		}
		NearbyScanViewController.show()
	}
}
