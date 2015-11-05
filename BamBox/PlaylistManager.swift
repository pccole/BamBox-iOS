//
//  PlaylistManager.swift
//  BamBox
//
//  Created by Phil Cole on 10/15/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit
import SwiftyJSON

class PlaylistManager {
    
    static let singleton = PlaylistManager()
    
    private var playlistsArray = [Playlist]()
    
    init() {
        
    }
    
    func addPlaylist(playlist:Playlist) {
        playlistsArray.append(playlist)
    }
    
    func removePlaylist(playlist:Playlist) {
        // come back to this one
    }
    
    func playlistAtIndex(index:Int) -> Playlist {
        return playlistsArray[index]
    }
}