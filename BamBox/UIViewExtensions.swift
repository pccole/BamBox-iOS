//
//  UIViewExtensions.swift
//  BamBox
//
//  Created by Phil Cole on 1/23/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	func pinToSuperview() {
		translatesAutoresizingMaskIntoConstraints = false
		guard let sTopAnchor = superview?.topAnchor,
			let sLeadingAnchor = superview?.leadingAnchor,
			let sTrailingAnchor = superview?.trailingAnchor,
			let sBottomAnchor = superview?.bottomAnchor
			else { return }
		topAnchor.constraint(equalTo: sTopAnchor).isActive = true
		leadingAnchor.constraint(equalTo: sLeadingAnchor).isActive = true
		trailingAnchor.constraint(equalTo: sTrailingAnchor).isActive = true
		bottomAnchor.constraint(equalTo: sBottomAnchor).isActive = true
	}
}
