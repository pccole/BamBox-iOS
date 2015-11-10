//
//  Fonts.swift
//  BamBox
//
//  Created by Phil Cole on 11/9/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import Foundation
import UIKit


enum Colors:Int {
    case Purple = 0x9B00FF
    case Orange = 0xFC450A
    case Yellow = 0xFEE40A
    case Green = 0x59FF0A
    case Pink = 0xE300A8
    case Blue = 0x1FECF7
}


extension UIColor {
    class func rgba(r:Int, g:Int, b:Int, a:Float) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255, alpha:CGFloat(a))
    }
    
    class func colorWithHex(hex: Int) -> UIColor {
        let red =   (hex & 0xff0000) >> 16
        let green = (hex & 0x00ff00) >> 8
        let blue  = hex & 0x0000ff
        let color = UIColor(red: CGFloat(red)/256.0, green: CGFloat(green)/256.0, blue: CGFloat(blue)/256.0, alpha: CGFloat(1.0))
        return color
    }
    
    class func attributedRandomizedColorString(string:String) -> NSAttributedString {
        return NSAttributedString()
    }
}