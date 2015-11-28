//
//  Playlist.swift
//  BamBox
//
//  Created by Phil Cole on 10/9/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit
import SwiftyJSON

public class Playlist {
    
    var id:Int = 0
    var name:String!
    private var owner_token:String!
    private var participant_token:String!
    private var song_plays:[String]!
    private var spotifyTrackArray:[SPTPartialTrack] = [SPTPartialTrack]()
    
    
    convenience init(map:JSON) {
        self.init()
        id = map["id"].int!
        name = map["name"].string
        owner_token = map["owner_token"].string
        participant_token = map["participant_token"].string
        song_plays = map["song_plays"].arrayObject as! [String]
    }
    
    func addTrackToPlaylist(track:SPTPartialTrack, completion:(Bool) -> Void) {
        WebService.singleton.postSong(track, playlist: self) { (bool) -> Void in
            if bool {
                self.spotifyTrackArray.append(track)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func spotifyTrackAtIndex(index:Int) -> SPTPartialTrack {
        return spotifyTrackArray[index]
    }
    
    func spotifyTrackCount() -> Int {
        return spotifyTrackArray.count
    }
    
    func participantToken() -> String {
        return participant_token
    }
}
