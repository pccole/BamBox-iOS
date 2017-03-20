//
//  NearbyScanViewController.swift
//  BamBox
//
//  Created by Phil Cole on 3/19/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit

class NearbyScanViewController: BamBoxViewController {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var playlistTitle: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		nearby.scan()
    }

	static func show() {
		navRouter.pushViewController(NearbyScanViewController())
	}
	
}
