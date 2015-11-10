//
//  HomeScreenVC.swift
//  BamBox
//
//  Created by Phil Cole on 10/9/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController {

    @IBOutlet weak var startPlaylistButton: UIButton!
    @IBOutlet weak var scanPlaylistButton: UIButton!
    @IBOutlet weak var startPlaylistLabel: UILabel!
    @IBOutlet weak var scanPlaylistLabel: UILabel!
    @IBOutlet weak var bamBoxIV: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bamBoxIV.userInteractionEnabled = true
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "broadCast")
        bamBoxIV.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startPlaylistTapped(sender: AnyObject) {
        NavRouter.router().pushStartPlaylist()
    }

    @IBAction func scanPlaylistTapped(sender: AnyObject) {
        NavRouter.router().showScanForPlaylist()
    }

    func broadCast() {
        NavRouter.router().pushBroadCastPlaylistVC()
    }

}
