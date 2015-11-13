//
//  MyPlaylistsVC.swift
//  BamBox
//
//  Created by Phil Cole on 11/10/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class MyPlaylistsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Playlists"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(PlaylistTableViewCell.self, forCellReuseIdentifier: PlaylistTableViewCell.kPlaylistID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// Mark - UITableViewDelegate

extension MyPlaylistsVC {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistManager.singleton.playlistCount()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(PlaylistTableViewCell.kPlaylistID, forIndexPath: indexPath) as! PlaylistTableViewCell
        let playlist = PlaylistManager.singleton.playlistAtIndex(indexPath.row)
        cell.playlist = playlist
        cell.textLabel?.text = playlist.name
        return cell
    }
}

// Mark - UITableViewDataSource

extension MyPlaylistsVC {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! PlaylistTableViewCell
        cell.broadCastPlaylist()
    }
}