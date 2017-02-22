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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	@IBAction func createPlaylistTapped(_ sender: UIButton) {
		guard sptService.isValidSession else {
			LoginViewController.show() { CreateBamBoxViewController.show() }
			return
		}
		CreateBamBoxViewController.show()
	}
	
	@IBAction func scanForBamBox(_ sender: UIButton) {
		guard sptService.isValidSession else {
			LoginViewController.show() { ScanBamBoxViewController.show() }
			return
		}
		ScanBamBoxViewController.show()
	}
}
