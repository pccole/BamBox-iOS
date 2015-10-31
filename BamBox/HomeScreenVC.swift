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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startPlaylistTapped(sender: AnyObject) {
//        self.navigationController?.pushViewController(StartPlaylistVC(nibName:nil, bundle:nil), animated: true)
        Bluetooth.singleton.switchBroadcastingState()
    }

    @IBAction func scanPlaylistTapped(sender: AnyObject) {
        Bluetooth.singleton.scan()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
