//
//  PlaylistInterface.swift
//  BamBox
//
//  Created by Phil Cole on 11/4/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

protocol PlaylistInterface {
    func createPlaylistWithTitle(_ title:String, completion:(Bool) -> Void)
    func addPlaylist(_ playlist:Playlist)
    func removePlaylist(_ playlist:Playlist)
    func playlistAtIndex(_ index:Int) -> Playlist
}
