//
//  LoginViewController.swift
//  BamBox
//
//  Created by Phil Cole on 1/23/17.
//  Copyright © 2017 Phil Cole. All rights reserved.
//

import UIKit

class LoginViewController: BamBoxViewController {

	static func show() {
		navRouter.mainView(controller: LoginViewController())
		navRouter.isNavigationBarHidden = true
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
