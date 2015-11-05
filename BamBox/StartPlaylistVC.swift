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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        playlistTextField.delegate = self
        playlistTextField.returnKeyType = UIReturnKeyType.Done
        playlistTextField.textColor = UIColor.whiteColor()
        playlistTextField.placeholder = "Enter Playlist Name"
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        WebService.singleton.postPlaylist(textField.text!) { (success) -> Void in
            if success {
                BLE.singleton.switchBroadcastingState()
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }
        return true
    }
}
