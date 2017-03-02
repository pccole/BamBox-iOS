
//
//  SPTPartialPlaylist.swift
//  BamBox
//
//  Created by Phil Cole on 3/2/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation

extension SPTPartialPlaylist: ListItem {
	
	var displayImage: String {
		get {
			return self.smallestImage.imageURL.absoluteString
		}
	}
	
	var displayTitle: String {
		get {
			return self.name
		}
	}
	
}
