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
}
