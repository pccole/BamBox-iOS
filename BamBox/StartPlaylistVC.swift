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

        playlistTextField.delegate = self
        playlistTextField.returnKeyType = UIReturnKeyType.Done
        playlistTextField.textColor = UIColor.whiteColor()
        playlistTextField.placeholder = "Playlist"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print(textField.text)
        WebService.shared.postPlaylist(textField.text!) { (success) -> Void in
            if success {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }
        return true
    }
}
