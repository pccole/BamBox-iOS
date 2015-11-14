//
//  NavRouter.swift
//  BamBox
//
//  Created by Phil Cole on 11/10/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

class NavRouter: UIViewController {
    
    let masterNav = UINavigationController()
    
    var topViewController:UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func popViewController(animated:Bool) {
        self.masterNav.popViewControllerAnimated(true)
    }
    
    func showLoginScreen() {
        let loginScreen = LoginScreenVC(nibName:nil, bundle:nil)
        addChildViewController(loginScreen)
    }

    func showHomeScreen() {
        let homeScreen = HomeScreenVC(nibName:nil, bundle:nil)
        self.masterNav.setViewControllers([homeScreen], animated: false)
        self.masterNav.navigationBarHidden = true
        self.masterNav.navigationBar.translucent = false
        self.masterNav.navigationBar.backgroundColor = UIColor.clearColor()
        if self.topViewController != nil {
            self.deactivateChildVC(self.topViewController, animated: true) { () -> Void in
                self.activateChildVC(self.masterNav, animated: true, completion: nil)
            }
        } else {
            self.activateChildVC(self.masterNav, animated: true, completion: nil)
        }
    }
    
    func pushStartPlaylist() {
        let playlistVC = StartPlaylistVC(nibName:nil, bundle:nil)
        self.masterNav.navigationBarHidden = false
        self.masterNav.pushViewController(playlistVC, animated: true)
    }
    
    func pushScanForPlaylist() {
        let scanPlaylist = ScanForPlaylistsVC(nibName:nil, bundle:nil)
        self.masterNav.navigationBarHidden = false
        self.masterNav.pushViewController(scanPlaylist, animated: true)
    }
    
    func pushPlaylistVC(playlist:Playlist) {
        let playlistVC = PlaylistVC(nibName:nil, bundle:nil)
        playlistVC.playlist = playlist
        self.masterNav.pushViewController(playlistVC, animated: true)
    }
    
    func pushMyPlaylists() {
        let myPlaylists = MyPlaylistsVC(nibName:nil, bundle:nil)
        self.masterNav.navigationBarHidden = false
        self.masterNav.pushViewController(myPlaylists, animated: true)
    }
    
    func pushSearchSpotify(playlist:Playlist) {
        let searchSpotify = SearchSpotifyVC(nibName:nil, bundle:nil)
        searchSpotify.playlist = playlist
        self.masterNav.pushViewController(searchSpotify, animated: true)
    }
    
    static func router() -> NavRouter {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDel.navRouter!
    }
    
    override func addChildViewController(childController: UIViewController) {
        super.addChildViewController(childController)
        childController.view.frame = view.frame
        view.addSubview(childController.view)
        childController.didMoveToParentViewController(self)
        self.topViewController = childController
    }
    
    func activateChildVC(childVC:UIViewController, animated:Bool, completion:(() -> Void)?) {
        addChildViewController(childVC)
        childVC.view.alpha = 0
        UIView.animateWithDuration(0.3) { () -> Void in
            childVC.view.alpha = 1
        }
    }
    
    func deactivateChildVC(childVC:UIViewController, animated:Bool, completion:() -> Void) {
        if animated {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                childVC.view.alpha = 0
                self.deactivateChildVC(childVC)
                completion()
            })
        } else {
            deactivateChildVC(childVC)
            completion()
        }
    }
    
    func deactivateChildVC(childVC:UIViewController) {
        childVC.willMoveToParentViewController(nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParentViewController()
        childVC.didMoveToParentViewController(nil)
    }
}
