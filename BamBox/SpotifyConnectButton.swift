//
//  SpotifyConnectButton.swift
//  BamBox
//
//  Created by Phil Cole on 2/20/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit

class SpotifyConnectButton: SPTConnectButton {
	
	private var callback:Callback?
	
	convenience init(_ callback:Callback?) {
		self.init(frame: CGRect.zero)
		self.callback = callback
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	func commonInit() {
		addTarget(self, action: #selector(loginTapped), for: UIControlEvents.touchUpInside)
	}
	
	@objc private func loginTapped() {
		sptService.login(callback: callback)
	}
}
