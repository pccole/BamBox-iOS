//
//  ScanForPlaylistsVC.swift
//  BamBox
//
//  Created by Phil Cole on 11/10/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class ScanForPlaylistsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "BamBox Playlists"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(BroadCastTableViewCell.self, forCellReuseIdentifier: "cell")
        BLE.singleton.scan { () -> Void in
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ScanForPlaylistsVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistManager.singleton.broadCastPlaylistCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BroadCastTableViewCell
        let playlist = PlaylistManager.singleton.broadCastPlaylistAtIndex(indexPath.row)
        cell.textLabel?.text = playlist.name
        cell.playlist = playlist
        return cell
    }
}

extension ScanForPlaylistsVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! BroadCastTableViewCell
        cell.pushToPlaylist()
    }
}
