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
    
    let id:Int!
    let name:String!
    let owner_token:String!
    let participant_token:String!
    var song_plays:[String]!
    private var spotifyTrackArray:[SPTPartialTrack] = [SPTPartialTrack]()
    
    init(map:JSON) {
        id = map["id"].intValue
        name = map["name"].string
        owner_token = map["owner_token"].string
        participant_token = map["participant_token"].string
        song_plays = map["song_plays"].arrayObject as! [String]
    }
    
    func addTrackToPlaylist(track:SPTPartialTrack, completion:(Bool) -> Void) {
        self.spotifyTrackArray.append(track)
        completion(true)
//        WebService.singleton.postSong(track, playlist: self) { (bool) -> Void in
//            if bool {
//                self.spotifyTrackArray.append(track)
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
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
    
    func ownerToken() -> String {
        return owner_token
    }
}
