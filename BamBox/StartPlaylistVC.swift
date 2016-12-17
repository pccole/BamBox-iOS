//
//  StartPlaylistVC.swift
//  BamBox
//
//  Created by Phil Cole on 10/9/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class StartPlaylistVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var playlistTextField: UITextField!
    @IBOutlet weak var newPlaylistTFView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.playlistTextField.delegate = self
        self.playlistTextField.returnKeyType = UIReturnKeyType.done
        self.playlistTextField.textColor = UIColor.white
        self.playlistTextField.placeholder = "Enter Playlist Name"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        PlaylistManager.singleton.createPlaylistWithTitle(textField.text!) { (bool) -> Void in
            if bool {
                
            }
        }
        return true
    }
}
