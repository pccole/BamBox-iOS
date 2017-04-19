//
//  PlayerViewController.swift
//  BamBox
//
//  Created by Phil Cole on 4/18/17.
//  Copyright © 2017 BamBox. All rights reserved.
//

import UIKit

class PlayerViewController: BaseViewController {

	@IBOutlet weak var titleLable: UILabel!
	@IBOutlet weak var albumLabel: UILabel!
	@IBOutlet weak var pauseButton: UIButton!
	@IBOutlet weak var playButton: UIButton!
	@IBOutlet weak var forwardButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
