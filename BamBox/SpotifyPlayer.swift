//
//  SpotifyPlayer.swift
//  BamBox
//
//  Created by Phil Cole on 4/18/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation


class SpotifyPlayer {
	
	static func play(track:SPTTrack) {
		let token = SPTAuth.defaultInstance().session.accessToken
		SPTAudioStreamingController.sharedInstance().login(withAccessToken: token)
		SPTAudioStreamingController.sharedInstance().playSpotifyURI(track.uri.absoluteString, startingWith: 0, startingWithPosition: 0) { (error:Error?) in
			print("Playing: \(track.displayHeader)")
		}
	}
	
}
