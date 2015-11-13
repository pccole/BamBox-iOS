//
//  PlaylistManager.swift
//  BamBox
//
//  Created by Phil Cole on 10/15/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit
import SwiftyJSON

class PlaylistManager:PlaylistInterface {
    
    static let singleton = PlaylistManager()
    
    internal var playlistArray = [Playlist]()
    
    internal var broadCastPlaylist = [Playlist]()
    
    init() {
        
    }
    
    func createPlaylistWithTitle(title:String, completion:(Bool) -> Void) {
        WebService.singleton.postPlaylist(title) { (bool, json) -> Void in
            if bool {
                let playlist = Playlist(map: json!)
                self.addPlaylist(playlist)
                NavRouter.router().pushPlaylistVC(playlist)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func getPlaylistById(id:Int, completion:(Bool) -> Void) {
        WebService.singleton.getPlaylist(id) { (bool, json) -> Void in
            if bool {
                self.broadCastPlaylist.append(Playlist(map: json!))
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func addPlaylist(playlist:Playlist) {
        self.playlistArray.append(playlist)
    }
    
    func removePlaylist(playlist:Playlist) {
        // come back to this one
    }
    
    func playlistAtIndex(index:Int) -> Playlist {
        return self.playlistArray[index]
    }
    
    func playlistCount() -> Int {
        return self.playlistArray.count
    }
    
    func broadCastPlaylistCount() -> Int {
        return self.broadCastPlaylist.count
    }
    
    func addBroadCastPlaylist(playlist:Playlist) {
        self.broadCastPlaylist.append(playlist)
    }
    
    func broadCastPlaylistAtIndex(index:Int) -> Playlist {
        return self.broadCastPlaylist[index]
    }
}