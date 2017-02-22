//
//  LoginViewController.swift
//  BamBox
//
//  Created by Phil Cole on 1/23/17.
//  Copyright © 2017 Phil Cole. All rights reserved.
//

import UIKit

class LoginViewController: BamBoxViewController {
	
	private var spotifyButton:SpotifyConnectButton!
	private var callback:Callback?
	
	convenience init(callback:Callback?) {
		self.init(nibName: nil, bundle: nil)
		self.callback = callback
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		callback = nil
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	class func show(_ callback:Callback?) {
		navRouter.setMainViewController(LoginViewController(callback:callback), animated: true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		spotifyButton = SpotifyConnectButton(callback)
	}
	
	@IBAction func signInToSpotifyTapped(_ sender: SPTConnectButton) {
		sptService.login(callback: callback)
	}
}
