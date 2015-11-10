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
    override func viewDidLoad() {
        super.viewDidLoad()

        BLE.singleton.scan { () -> Void in
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}