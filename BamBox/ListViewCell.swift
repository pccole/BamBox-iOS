//
//  PlaylistTableViewCell.swift
//  BamBox
//
//  Created by Phil Cole on 3/6/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit
import AlamofireImage

class ListViewCell: UITableViewCell {

	@IBOutlet weak var albumArt: UIImageView!
	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var subHeaderLabel: UILabel!
	@IBOutlet weak var albumArtWidthConstraint: NSLayoutConstraint!
	
	static let identifier = "ListViewCell"
	
	private var sptPlaylist:SPTPartialPlaylist?
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		albumArt.image = nil
		sptPlaylist = nil
		albumArtWidthConstraint.constant = 0
	}

	func configure(for listItem:ListItem) {
		headerLabel.text = listItem.displayHeader
		subHeaderLabel.text = listItem.displaySubheader
		guard let url = listItem.displayImageURL else {
			albumArtWidthConstraint.constant = 0
			return
		}
		albumArtWidthConstraint.constant = 60
		albumArt.af_setImage(withURL: url)
	}
	
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}
