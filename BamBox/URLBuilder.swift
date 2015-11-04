//
//  URLBuilder.swift
//  BamBox
//
//  Created by Phil Cole on 9/19/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit
import Alamofire

class WebService:NSObject {
    
    static let shared = WebService()
    
    let baseURL: String = "http://be-util02.jrforrest.net:9292/api"
    
    func postPlaylist(playlist:String, completion:(Bool) -> Void) {
        let params = ["name":playlist]
        Alamofire.request(.POST, "\(baseURL)/playlist", parameters:params).responseJSON { (request:NSURLRequest?, response:NSHTTPURLResponse?, result:Result<AnyObject>) -> Void in
            //
            PlaylistManager.singleton.addPlaylist(Playlist(dictionary: result.value as! [String:AnyObject]))
        }
    }
}
