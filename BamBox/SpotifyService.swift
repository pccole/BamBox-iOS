//
//  SpotifyService.swift
//  BamBox
//
//  Created by Phil Cole on 12/17/16.
//  Copyright © 2016 Phil Cole. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import Alamofire

struct Spotify {
	static let clientId = "7c04cbd6b7e946879649b5634f4f9beb"
	static let clientSecret = "74aa545683ec4f398dd88fdcb38a5a00"
	static let redirect = "bamboxapp://"
	static let tokenSwqp = "http://localhost:8080/swap"
	static let refreshTokenService = "http://localhost:8080/refresh"
}

typealias ListItemCallback = (() throws -> [ListItem]) -> Void

let sptService = SpotifyService()

class SpotifyService: NSObject {
	
	var isValidSession: Bool {
		get {
			guard let auth = SPTAuth.defaultInstance(), let session = auth.session else { return false }
			return session.isValid()
		}
	}
	
	var session:SPTSession? {
		get {
			guard let auth = SPTAuth.defaultInstance(), let s = auth.session, s.isValid() else {
				return nil
			}
			return s
		}
	}
	
	var user:SPTUser?
	
	fileprivate var loginCallback:Callback?
	
	fileprivate override init() {
		super.init()
		guard let auth = SPTAuth.defaultInstance() else { return }
		auth.clientID = Spotify.clientId
		auth.redirectURL = Spotify.redirect.url()
		auth.sessionUserDefaultsKey = "SpotifySession"
	}
	
	
}


// MARK: Login
extension SpotifyService {
	
	func login(callback:Callback?) {
		loginCallback = callback
		let scopes = [SPTAuthStreamingScope,
		              SPTAuthUserReadPrivateScope,
		              SPTAuthUserLibraryReadScope,
		              SPTAuthPlaylistReadCollaborativeScope,
		              SPTAuthPlaylistReadPrivateScope,
		              SPTAuthPlaylistModifyPublicScope,
		              SPTAuthPlaylistModifyPrivateScope,
		              SPTAuthUserReadTopScope]
		guard let redirctURL = Spotify.redirect.url(),
			let url = SPTAuth.loginURL(forClientId: Spotify.clientId, withRedirectURL: redirctURL, scopes: scopes, responseType: "token")
			else { return }
		navRouter.present(url: url)
	}
	
	func handLogin(with url:URL) -> Bool {
		guard let auth = SPTAuth.defaultInstance(),
			auth.canHandle(url)
			else { return false }
		auth.handleAuthCallback(withTriggeredAuthURL: url) { (error:Error?, session:SPTSession?) in
			guard let s = session else {
				if let e = error {
					print(e.localizedDescription)
				}
				return
			}
			auth.session = s
			self.loginCallback?()
			self.getUser(userCallback: nil)
		}
		return true
	}

}

// MARK: Requests

extension SpotifyService {
	func getUser(userCallback:((SPTUser?) -> Void)?) {
		SPTUser.requestCurrentUser(withAccessToken: session?.accessToken) { (error:Error?, user:Any?) in
			guard let u = user as? SPTUser else {
				userCallback?(nil)
				return
			}
			self.user = u
			userCallback?(u)
		}
	}
	
	func getAllPlaylist(_ playlistCallback:@escaping ListItemCallback)  {
		guard let u = user, let s = session else {
			playlistCallback({ throw NSError.init(domain: "BamBox", code: 1, userInfo: nil) })
			return
		}
		
		SPTPlaylistList.playlists(forUser: u.canonicalUserName, withAccessToken: s.accessToken) { (error:Error?, sptPlaylist:Any?) in
			guard let playlist = sptPlaylist as? SPTPlaylistList, let partialPlaylist = playlist.items as? [SPTPartialPlaylist] else {
				playlistCallback({ throw NSError.init(domain: "BamBox", code: 1, userInfo: nil) })
				return
			}
			print(playlist)
			playlistCallback({return partialPlaylist})
		}
	}
	
	func getTracks(for playlist:SPTPartialPlaylist, listItemCallback:@escaping ListItemCallback) {
		
		guard let url = playlist.uri, let accessToken = session?.accessToken else {
			listItemCallback({ throw NSError.init(domain: "BamBox", code: 1, userInfo: nil) })
			return
		}
		
		SPTPlaylistSnapshot.playlist(withURI: url, accessToken: accessToken) { (error:Error?, snap:Any?) in
			guard let s = snap as? SPTPlaylistSnapshot, let tracks = s.firstTrackPage.items as? [ListItem] else {
				listItemCallback({ throw NSError.init(domain: "BamBox", code: 1, userInfo: nil) })
				return
			}
			listItemCallback({ return tracks })
		}
	}
	
	func getPlaylist(withURI uri: String, callback:((_ playlist:SPTPartialPlaylist) -> Void)?) {
		let playlistId = uri.substringAfterLastOccurence(of: ":")!
		let userId = user!.uri.absoluteString.substringAfterLastOccurence(of: ":")!
		let uri = "https://api.spotify.com/v1/users/\(userId)/playlists/\(playlistId)"
		let header = ["Authorization" : "Bearer \(session!.accessToken!)"]
		print("Header: \(header)")
		print("URI: \(uri)")
		Alamofire.request(uri, method: .get, parameters: nil, headers: header).responseJSON { (result:DataResponse<Any>) in
			guard result.result.isSuccess,
				let json = result.result.value as? [String:AnyObject] else {
					return
			}
			print("Json from spotify: \(json)")
			do {
				let playlist = try SPTPartialPlaylist(fromDecodedJSON: json)
				print("Playlist Retrived: \(playlist)")
				callback?(playlist)
			} catch {
				print(error)
			}
		}
	}
}
			
	
	

