
//
//  SPTPartialPlaylist.swift
//  BamBox
//
//  Created by Phil Cole on 3/2/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation

extension SPTPartialPlaylist: ListItem {
	
	var displayImageURL: URL? {
		get {
			return self.smallestImage.imageURL
		}
	}
	
	var displayHeader: String {
		get {
			return self.name
		}
	}
	
	var displaySubheader: String {
		get {
			return self.owner.displayName ?? "owner"
		}
	}
	
}
