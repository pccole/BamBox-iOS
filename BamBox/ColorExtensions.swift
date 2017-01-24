//
//  ColorExtensions.swift
//  BamBox
//
//  Created by Phil Cole on 1/23/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
	convenience init(hex:Int) {
		let red =   CGFloat((hex & 0xff0000) >> 16 / 255)
		let green = CGFloat((hex & 0x00ff00) >> 8 / 255)
		let blue  = CGFloat(hex & 0x0000ff / 255)
		self.init(red: red, green: green, blue: blue, alpha: 1.0)
	}
	
	convenience init(r:Int, g:Int, b:Int) {
		let red = CGFloat(r/255)
		let green = CGFloat(g/255)
		let blue = CGFloat(b/255)
		self.init(red: red, green: green, blue: blue, alpha: 1.0)
	}
	
}
