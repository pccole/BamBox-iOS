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
    
    private let kClientID = "7c04cbd6b7e946879649b5634f4f9beb"
    private let kClientSecret = "74aa545683ec4f398dd88fdcb38a5a00"
    private let kRedirectURLString = "BamBoxiOSApp://"
    private let kTokenSwapURL = ""
    private let kTokenRefreshServiecURL = ""
    
    override init () {
    }
    
    func openSpotifyAuth() {
        SPTAuth.defaultInstance().clientID = self.kClientID
        SPTAuth.defaultInstance().redirectURL = NSURL(string: self.kRedirectURLString)
        UIApplication.sharedApplication().openURL(SPTAuth.defaultInstance().loginURL)
        SPTAuth.loginURLForClientId(self.kClientID, withRedirectURL: NSURL(string: self.kRedirectURLString), scopes: [SPTAuthStreamingScope], responseType:"com.BamBox.BamBox")
    }
    
}