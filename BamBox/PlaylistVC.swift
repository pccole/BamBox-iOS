//
//  BroadCastPlaylistVC.swift
//  BamBox
//
//  Created by Phil Cole on 11/10/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class PlaylistVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var playlist:Playlist!
    
    var addBarButtonItem:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = playlist.name
        self.addBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(PlaylistVC.pushSearchSpotifyVC))
        self.navigationItem.rightBarButtonItem = self.addBarButtonItem
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func pushSearchSpotifyVC() {
        NavRouter.router().pushSearchSpotify(self.playlist)
    }
}

extension PlaylistVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playlist.spotifyTrackCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let partialTrack = self.playlist.spotifyTrackAtIndex(indexPath.row)
        cell.textLabel?.text = partialTrack.name
        return cell
    }
}

extension PlaylistVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SpotifyService.singleton.playMusicUsingTrack(self.playlist.spotifyTrackAtIndex(indexPath.row))
    }
}
