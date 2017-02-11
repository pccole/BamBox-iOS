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
	
	fileprivate init() { }
	
	func login() {
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
					// display error
				}
				return
			}
			auth.session = s
		}
		return true
	}
}
//SPTAuth *auth = [SPTAuth defaultInstance];
//
//SPTAuthCallback authCallback = ^(NSError *error, SPTSession *session) {
//	// This is the callback that'll be triggered when auth is completed (or fails).
//	
//	if (error) {
//		NSLog(@"*** Auth error: %@", error);
//	} else {
//		auth.session = session;
//	}
//	[[NSNotificationCenter defaultCenter] postNotificationName:@"sessionUpdated" object:self];
//};
//
///*
//Handle the callback from the authentication service. -[SPAuth -canHandleURL:]
//helps us filter out URLs that aren't authentication URLs (i.e., URLs you use elsewhere in your application).
//*/
//
//if ([auth canHandleURL:url]) {
//	[auth handleAuthCallbackWithTriggeredAuthURL:url callback:authCallback];
//	return YES;
//}
