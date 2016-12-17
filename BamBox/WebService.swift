//
//  URLBuilder.swift
//  BamBox
//
//  Created by Phil Cole on 9/19/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit
import Alamofire

class WebService:NSObject {
    
    static let singleton = WebService()
    
    let baseURL: String = "http://be-util02.jrforrest.net:9292/api"

    func postPlaylist(_ playlist:String, completion:(Bool, JSON?) -> Void) {
        let params = ["name":playlist]
        Alamofire.request(.POST, "\(baseURL)/playlist", parameters: params).responseJSON { (response) -> Void in
            if response.result.isFailure {
                completion(false, nil)
            } else {
                let json = JSON(response.result.value!)
                completion(true, json)
            }
        }
    }
    
    func getPlaylist(_ playlistID:Int, completion:(Bool, JSON?) -> Void) {
        Alamofire.request(.GET, "\(baseURL)/playlist/\(playlistID)").responseJSON(completionHandler: { (response) -> Void in
            if response.result.isFailure {
                completion(false, nil)
            } else {
                let json = JSON(response.result.value!)
                completion(true, json)
            }
        })
    }
    
    func postSong(_ song:SPTPartialTrack, playlist:Playlist, completion:@escaping (Bool) -> Void) {
        let params = ["song_spotify_id":song.identifier, "token": playlist.ownerToken()]
        Alamofire.request(.POST, "\(baseURL)/playlist/\(playlist.id)/song)", parameters: params).responseJSON(completionHandler: { (response) -> Void in
            if case 200...209 = response.response!.statusCode {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
}
