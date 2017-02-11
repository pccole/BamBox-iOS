//
//  SpotifyConnectButton.swift
//  BamBox
//
//  Created by Phil Cole on 1/25/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation


@IBDesignable
class SpotifyConnectButton: SPTConnectButton {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		addTarget(self, action: #selector(spotifyConnectButtonTouched), for: UIControlEvents.touchUpInside)
	}
	
	@objc private func spotifyConnectButtonTouched() {
		let auth = SPTAuth.defaultInstance()
		if SPTAuth.supportsApplicationAuthentication() {
			UIApplication.shared.open(auth!.spotifyAppAuthenticationURL(), options: [:], completionHandler: nil)
		} else {
			guard let redirctURL = BamBoxSpotify.redirect.url(),
				let url = SPTAuth.loginURL(forClientId: BamBoxSpotify.clientId, withRedirectURL: redirctURL, scopes: [SPTAuthStreamingScope], responseType: nil)
				else { return }
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
		}
	}
}
