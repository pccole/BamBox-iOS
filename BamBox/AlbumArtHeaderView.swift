//
//  BamBoxHeaderView.swift
//  BamBox
//
//  Created by Phil Cole on 3/14/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit

class AlbumArtHeaderView: UIView {

	lazy var smallImageView:UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		return view
	}()
	
	lazy var largeImageView:UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		view.heightAnchor.constraint(equalToConstant: 60).isActive = true
		return view
	}()
	
	lazy var blurImageView:UIVisualEffectView = {
		let effect = UIBlurEffect(style: UIBlurEffectStyle.dark)
		let view = UIVisualEffectView(effect: effect)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.topAnchor.constraint(equalTo: self.topAnchor)
		view.leadingAnchor.constraint(equalTo: self.leadingAnchor)
		view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	convenience init(playlist:SPTPlaylistList) {
		self.init(frame: CGRect.zero)
	}
	
}
