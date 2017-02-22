//
//  ScanBamBoxViewController.swift
//  BamBox
//
//  Created by Phil Cole on 2/20/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit

class ScanBamBoxViewController: BamBoxViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override class func show() {
		navRouter.setMainViewController(ScanBamBoxViewController())
	}
}
