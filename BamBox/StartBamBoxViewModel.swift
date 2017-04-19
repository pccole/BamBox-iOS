//
//  StartBamBoxViewModel.swift
//  BamBox
//
//  Created by Phil Cole on 3/25/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation
import UIKit

class StartBamBoxViewModel: TracksListViewModel {
	override func viewDidLoad(_ vc: ListViewController) {
		let start = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startBamBox))
		vc.navigationItem.rightBarButtonItem = start
	}
	
	@objc private func startBamBox() {
		
	}
}
