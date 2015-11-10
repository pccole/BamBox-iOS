//
//  LoginScreenVC.swift
//  BamBox
//
//  Created by Phil Cole on 11/9/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class LoginScreenVC: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        SpotifyService.singleton.openSpotifyAuth()
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
