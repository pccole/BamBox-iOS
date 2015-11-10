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
    
    init() {
        
    }
    
    func addPlaylist(playlist:Playlist) {
        playlistArray.append(playlist)
    }
    
    func removePlaylist(playlist:Playlist) {
        // come back to this one
    }
    
    func playlistAtIndex(index:Int) -> Playlist {
        return playlistArray[index]
    }
}