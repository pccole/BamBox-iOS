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
    var player:SPTAudioStreamingController!
    
    var addBarButtonItem:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = playlist.name
        self.addBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "pushSearchSpotifyVC")
        self.navigationItem.rightBarButtonItem = self.addBarButtonItem
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pushSearchSpotifyVC() {
        NavRouter.router().pushSearchSpotify()
    }
    
    func playMusicUsingSession(session:SPTSession) {
        if self.player == nil {
            self.player = SPTAudioStreamingController(clientId: SpotifyService.singleton.kClientID)
        }
        if let session = SpotifyService.singleton.spotifySession() {
            
            if self.player.loggedIn {
                print("logged in")
                SPTTrack.trackWithURI(NSURL(string: "spotify:track:2RnOD4XZtdIIRL7ZWJtNZP"), session: session, callback: { (error:NSError!, result:AnyObject!) -> Void in
                    let track = result as! SPTTrack
                    self.player.playURIs([track.uri], withOptions: SPTPlayOptions(), callback: nil)
                })
            } else {
                self.player.loginWithSession(session) { (error:NSError!) -> Void in
                    if error != nil {
                        print("error logging in \(error.localizedDescription)")
                    }
                    
                    
                }
            }
        }
    }
}

extension PlaylistVC {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.playlist.song_plays.count
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = "play song"
        return cell
    }
}

extension PlaylistVC {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.playMusicUsingSession(SpotifyService.singleton.spotifySession()!)
    }
}