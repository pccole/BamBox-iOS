//
//  URLBuilder.swift
//  BamBox
//
//  Created by Phil Cole on 9/19/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WebService:NSObject {
    
    static let singleton = WebService()
    
    let baseURL: String = "http://be-util02.jrforrest.net:9292/api"

    func postPlaylist(playlist:String, completion:(Bool, JSON?) -> Void) {
        let params = ["name":playlist]
        Alamofire.request(.POST, "\(baseURL)/playlist", parameters: params).response { (request:NSURLRequest?, response:NSHTTPURLResponse?, data:NSData?, error:NSError?) -> Void in
            if let json:JSON = JSON(data: data!) {
                print(json)
                print(JSON(data: request!.HTTPBody!))
                completion(true, json)
            } else {
                completion(false, nil)
            }
        }
    }
    
    func getPlaylist(playlistID:Int, completion:(Bool, JSON?) -> Void) {
        Alamofire.request(.GET, "\(baseURL)/playlist/\(playlistID)").response { (request:NSURLRequest?, response:NSHTTPURLResponse?, data:NSData?, error:NSError?) -> Void in
            if let json:JSON = JSON(data: data!) {
                print(json)
                completion(true, json)
            } else {
                completion(false, nil)
            }
        }
    }
    
    func postSong(songURI:String, playlist:Playlist, completion:(Bool) -> Void) {
        let params = ["song_spotify_id":songURI]
        Alamofire.request(.POST, "\(baseURL)/playlist/\(playlist.id)/song)", parameters: params).response { (request:NSURLRequest?, response:NSHTTPURLResponse?, data:NSData?, error:NSError?) -> Void in
            
            if let json:JSON = JSON(data: data!) where error == nil {
                print(json)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
