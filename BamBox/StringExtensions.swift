//
//  StringExtensions.swift
//  BamBox
//
//  Created by Phil Cole on 1/25/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation

extension String {
	func url() -> URL? {
		return URL(string: self)
	}
	
	func index(after: String.Index, offsetBy:Int) -> String.Index {
		let start = index(after, offsetBy: offsetBy)
		return index(after: start)
	}
	
	func index(before: String.Index, offsetBy:Int) -> String.Index {
		let start = index(before, offsetBy: offsetBy)
		return index(before: start)
	}

	
	func substringAfterLastOccurence(of string:String) -> String? {
		var position:String.Index?
		for (i, c) in characters.enumerated() {
			if String(c).contains(string) {
				position = index(after: startIndex, offsetBy: i)
			}
		}
		guard let p = position else {
			return nil
		}
		return self[p..<endIndex]
	}
}
