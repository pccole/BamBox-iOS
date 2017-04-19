//
//  CreateBamBoxViewController.swift
//  BamBox
//
//  Created by Phil Cole on 2/20/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit

@IBDesignable
class CreateBamBoxViewController: BaseViewController {

	@IBOutlet weak var purpleView: UIView!
	@IBOutlet weak var yellowView: UIView!
	@IBOutlet weak var redView: UIView!
	@IBOutlet weak var greenView: UIView!
	@IBOutlet weak var textField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		commonInit()
    }

	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		commonInit()
	}
	
	private func commonInit() {
		purpleView.backgroundColor = BamBoxColor.purple
		yellowView.backgroundColor = BamBoxColor.yellow
		redView.backgroundColor = BamBoxColor.orange
		greenView.backgroundColor = BamBoxColor.green
		textField.delegate = self
	}
	
	static func show() {
		navRouter.pushViewController(CreateBamBoxViewController())
	}
}


extension CreateBamBoxViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return true
	}
}
