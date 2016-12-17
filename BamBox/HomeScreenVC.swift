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
        
        bamBoxIV.isUserInteractionEnabled = true
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeScreenVC.broadCast))
        bamBoxIV.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startPlaylistTapped(_ sender: AnyObject) {
        NavRouter.router().pushStartPlaylist()
    }

    @IBAction func scanPlaylistTapped(_ sender: AnyObject) {
        NavRouter.router().pushScanForPlaylist()
    }

    func broadCast() {
        NavRouter.router().pushMyPlaylists()
    }

}
