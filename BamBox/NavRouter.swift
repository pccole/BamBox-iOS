//
//  NavRouter.swift
//  BamBox
//
//  Created by Phil Cole on 12/17/16.
//  Copyright © 2016 Phil Cole. All rights reserved.
//

import UIKit

let navRouter = NavRouter()

class NavRouter: UIViewController {

	fileprivate let navController = UINavigationController()
	
	fileprivate override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		add(childVC: navController)
    }
}

extension NavRouter {
	fileprivate func add(childVC:UIViewController) {
		addChildViewController(navController)
		view.addSubview(navController.view)
		navController.view.pinToSuperview()
	}
}

extension NavRouter {
	var isNavigationBarHidden:Bool {
		get {
			return navController.navigationBar.isHidden
		}
		set {
			navController.navigationBar.isHidden = newValue
		}
	}
}

extension NavRouter {
	func mainView(controller:UIViewController, animated:Bool = false) {
		navController.setViewControllers([controller], animated: false)
		guard animated else { return }
		navController.view.alpha = 0
		UIView.animate(withDuration: 0.3) { 
			self.navController.view.alpha = 1
		}
	}
}


