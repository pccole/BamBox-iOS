//
//  PlaylsitViewController.swift
//  BamBox
//
//  Created by Phil Cole on 2/20/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit

class PlaylistViewController: BamBoxViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	class func show(title:String) {
		let playlist = PlaylistViewController()
		playlist.title = title
		navRouter.setMainViewController(playlist)
	}
}
