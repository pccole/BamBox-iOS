//
//  SpotifyService.swift
//  BamBox
//
//  Created by Phil Cole on 12/17/16.
//  Copyright © 2016 Phil Cole. All rights reserved.
//

import Foundation


struct BamBoxSpotify {
	static let clientId = "7c04cbd6b7e946879649b5634f4f9beb"
	static let clientSecret = "74aa545683ec4f398dd88fdcb38a5a00"
	static let redirect = "BamBoxiOSApp://"
	static let tokenSwqp = "http://localhost:8080/swap"
	static let refreshTokenService = "http://localhost:8080/refresh"
}


let sptService = SpotifyService()

class SpotifyService {
	
	var isValidSession: Bool {
		get {
			guard let auth = SPTAuth.defaultInstance(), let session = auth.session else { return false }
			return session.isValid()
		}
	}
	
	fileprivate init() {
		guard let auth = SPTAuth.defaultInstance() else { return }
		auth.clientID = BamBoxSpotify.clientId
		auth.redirectURL = BamBoxSpotify.redirect.url()
		
	}
	
	private var loginCallback:Callback?
	
	func login(callback:Callback?) {
		loginCallback = callback
		let scopes = [SPTAuthStreamingScope,
		              SPTAuthUserReadPrivateScope,
		              SPTAuthPlaylistReadCollaborativeScope,
		              SPTAuthPlaylistReadPrivateScope,
		              SPTAuthPlaylistModifyPublicScope,
		              SPTAuthPlaylistModifyPrivateScope]
		guard let redirctURL = BamBoxSpotify.redirect.url(),
		let url = SPTAuth.loginURL(forClientId: BamBoxSpotify.clientId, withRedirectURL: redirctURL, scopes: scopes, responseType: nil)
		else { return }
		UIApplication.shared.open(url, options: [:], completionHandler: nil)
	}
	
	func handLogin(with url:URL) -> Bool {
		guard let auth = SPTAuth.defaultInstance(), auth.canHandle(url) else { return false }
		auth.handleAuthCallback(withTriggeredAuthURL: url) { (error:Error?, session:SPTSession?) in
			guard let s = session else {
				if let e = error {
					print(e.localizedDescription)
				}
				return
			}
			auth.session = s
			self.loginCallback?()
		}
		return true
	}
}
