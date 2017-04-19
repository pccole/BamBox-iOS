//
//  BamBoxViewController.swift
//  BamBox
//
//  Created by Phil Cole on 1/23/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit


@IBDesignable
class BaseViewController: UIViewController {

	@IBInspectable var backgroundColor: UIColor {
		get {
			return view.backgroundColor ?? BamBoxColor.black
		}
		set {
			view.backgroundColor = newValue
		}
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
    }
	
	func setup() {
		view.backgroundColor = BamBoxColor.black
		UIApplication.shared.statusBarStyle = .lightContent
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setup()
	}

}

