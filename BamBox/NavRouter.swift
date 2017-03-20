//
//  NavRouter.swift
//  BamBox
//
//  Created by Phil Cole on 12/17/16.
//  Copyright © 2016 Phil Cole. All rights reserved.
//

import UIKit
import SafariServices

let navRouter = NavRouter()

class NavRouter {

	let navController: UINavigationController = {
		let nav = UINavigationController()
		nav.navigationBar.isTranslucent = false
		return nav
	}()
	
	var viewController: UIViewController {
		get {
			return navController
		}
	}
	
	fileprivate init() { }
	
}


extension NavRouter {
	var isNavigationBarHidden:Bool {
		get {
			return navController.navigationBar.isHidden
		}
		set {
			navController.setNavigationBarHidden(newValue, animated: true)
			guard newValue else {
				return
			}
			navController.navigationBar.backIndicatorImage = nil
			navController.navigationBar.backIndicatorTransitionMaskImage = nil
			navController.navigationBar.barTintColor = BamBoxColor.black
			navController.navigationBar.tintColor = UIColor.white
			let attributes = [NSForegroundColorAttributeName:UIColor.white]
			navController.navigationBar.titleTextAttributes = attributes
		}
	}
}

extension NavRouter {
	/**
		animated is false
	*/
	func setMainViewController(_ controller:UIViewController, animated:Bool = false) {
		navController.setViewControllers([controller], animated: false)
		guard animated else { return }
		navController.view.alpha = 0
		UIView.animate(withDuration: 0.3) { 
			self.navController.view.alpha = 1
		}
	}
	
	func setViewControllers(_ controllers:[UIViewController], animated:Bool = false) {
		navController.setViewControllers(controllers, animated: animated)
	}
	
	/**
		animated is true by default
	*/
	func pushViewController(_ viewController:UIViewController, animated:Bool = true) {
		navController.pushViewController(viewController, animated: animated)
		
	}
	
	/**
		animated is true by default
	*/
	func present(_ viewController:UIViewController, animated:Bool = true, completion:(() -> Void)? = nil) {
		navController.present(viewController, animated: animated, completion: completion)
	}
	
	func present(url URL:URL, animated:Bool = true, completion:(() -> Void)? = nil) {
		UIApplication.shared.statusBarStyle = .default
		let navController = UINavigationController(rootViewController: SFSafariViewController(url: URL))
		navController.isNavigationBarHidden = true
		present(navController, animated: animated, completion: completion)
	}
	
	func dismiss(animated flag: Bool = true, completion: (() -> Void)? = nil) {
		navController.dismiss(animated: flag, completion: completion)
	}
	
	
}


