//
//  SpotifyService.swift
//  BamBox
//
//  Created by Phil Cole on 11/9/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import Foundation
import SwiftyJSON


class SpotifyService:NSObject {
    static let singleton = SpotifyService()
    
    var playlist:Playlist!
    var player:SPTAudioStreamingController!
    
    var kClientID:String {
        get {
            return "7c04cbd6b7e946879649b5634f4f9beb"
        }
    }
    var kClientSecret:String {
        get {
            return "74aa545683ec4f398dd88fdcb38a5a00"
        }
    }
    var kRedirectURLString:String {
        get {
            return "BamBoxiOSApp://"
        }
    }
    var kTokenSwapURL:String {
        get {
            return "http://localhost:1234/swap"
        }
    }
    var kTokenRefreshServiecURL:String {
        get {
            return "http://localhost:1234/refresh"
        }
    }
    
    override init () {
        
    }
    
    func openSpotifyAuth() {
        SPTAuth.defaultInstance().clientID = self.kClientID
        SPTAuth.defaultInstance().redirectURL = NSURL(string: self.kRedirectURLString)
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope, SPTAuthUserLibraryReadScope]
        UIApplication.sharedApplication().openURL(SPTAuth.defaultInstance().loginURL)
    }
    
    func saveSpotifySession(session:SPTSession) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "premiumPurchased")
        
        let sessionData = NSKeyedArchiver.archivedDataWithRootObject(session)
        
        userDefaults.setObject(sessionData, forKey: "SpotifySession")
        
        userDefaults.synchronize()
        
        NavRouter.router().showHomeScreen()
    }
    
    func spotifySession() -> SPTSession? {
        if let sessionData:NSData = NSUserDefaults.standardUserDefaults().objectForKey("SpotifySession") as? NSData {
            let session = NSKeyedUnarchiver.unarchiveObjectWithData(sessionData) as! SPTSession
            return session
        } else {
            return nil
        }
    }
    
    func renewSpotifySession(complete:(bool:Bool) -> Void) {
        SPTAuth.defaultInstance().renewSession(spotifySession()) { (error:NSError!, session:SPTSession!) -> Void in
            if error != nil {
                self.saveSpotifySession(session)
                complete(bool: true)
            } else {
                complete(bool: false)
            }
        }
    }
    
    func searchSpotifyLibrary(searchQuery:String, completion:([SPTPartialTrack]) -> Void) {
        if let session = spotifySession() {
            SPTSearch.performSearchWithQuery(searchQuery, queryType: SPTSearchQueryType.QueryTypeTrack, accessToken: session.accessToken, callback: { (error:NSError!, result:AnyObject!) -> Void in
                print(result)
                let listPage = result as! SPTListPage
                if let items = listPage.items as? [SPTPartialTrack]{
                    print(items)
                    completion(items)
                }
            })
        }
    }
    func playMusicUsingTrack(track:SPTPartialTrack) {
        if self.player == nil {
            self.player = SPTAudioStreamingController(clientId: SpotifyService.singleton.kClientID)
        }
        if let session = SpotifyService.singleton.spotifySession() {
            
            if self.player.loggedIn {
                print("logged in")
                SPTTrack.trackWithURI(track.uri, session: session, callback: { (error:NSError!, result:AnyObject!) -> Void in
                    let track = result as! SPTTrack
                    self.player.playURIs([track.uri], withOptions: SPTPlayOptions(), callback: nil)
                })
            } else {
                self.player.loginWithSession(session) { (error:NSError!) -> Void in
                    if error != nil {
                        print("error logging in \(error.localizedDescription)")
                    }
                    SPTTrack.trackWithURI(track.uri, session: session, callback: { (error:NSError!, result:AnyObject!) -> Void in
                        let track = result as! SPTTrack
                        self.player.playURIs([track.uri], withOptions: SPTPlayOptions(), callback: nil)
                    })
                    
                }
            }
        }
    }

}