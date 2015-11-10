//
//  BroadCastPlaylistVC.swift
//  BamBox
//
//  Created by Phil Cole on 11/10/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class BroadCastPlaylistVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var playlist:Playlist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = playlist.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

