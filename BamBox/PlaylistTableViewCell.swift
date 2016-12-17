//
//  PlaylistTableViewCell.swift
//  BamBox
//
//  Created by Phil Cole on 11/10/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {
    
    var playlist:Playlist!
    
    static let kPlaylistID = "PlaylistTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.playlist = nil
    }
    
    func broadCastPlaylist() {
        BLE.singleton.broadCastPlaylist(self.playlist)
        NavRouter.router().pushPlaylistVC(self.playlist)
    }
}
