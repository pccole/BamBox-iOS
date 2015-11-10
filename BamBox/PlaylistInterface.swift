//
//  PlaylistInterface.swift
//  BamBox
//
//  Created by Phil Cole on 11/4/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

protocol PlaylistInterface {
    func createPlaylistWithTitle(title:String, completion:(Bool) -> Void)
    func addPlaylist(playlist:Playlist)
    func removePlaylist(playlist:Playlist)
    func playlistAtIndex(index:Int) -> Playlist
}
