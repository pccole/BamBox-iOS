//
//  BroadCastTableViewCell.swift
//  BamBox
//
//  Created by Phil Cole on 11/12/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class BroadCastTableViewCell: UITableViewCell {

    var playlist:Playlist!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.playlist = nil
    }
    
    func pushToPlaylist() {
        NavRouter.router().pushPlaylistVC(self.playlist)
    }
}
