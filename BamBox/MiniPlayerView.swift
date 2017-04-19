//
//  MiniPlayerView.swift
//  BamBox
//
//  Created by Phil Cole on 3/26/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import Foundation
import UIKit

class MiniPlayerView: UIView {
	
	private var playlist:SPTPlaylistList?
	@IBOutlet weak var imageView: UIImageView!
	
	private lazy var pauseButton:UIButton = {
		let button = UIButton(frame: CGRect.zero)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(#imageLiteral(resourceName: "PlayButton"), for: UIControlState.normal)
		button.heightAnchor.constraint(equalToConstant: 100)
		button.widthAnchor.constraint(equalToConstant: 100)
		return button
	}()
	
	private lazy var stopButton:UIButton = {
		return UIButton(frame: CGRect.zero)
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	@IBAction func playButtonTapped(_ sender: Any) {
		
	}
	
	@IBAction func pauseButtonTapped(_ sender: Any) {
		
	}
	
	@IBAction func forwardButtonTapped(_ sender: Any) {
		
	}
}
