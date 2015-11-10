//
//  URLBuilder.swift
//  BamBox
//
//  Created by Phil Cole on 9/19/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WebService:NSObject {
    
    static let singleton = WebService()
    
    let baseURL: String = "http://be-util02.jrforrest.net:9292/api"
    
    func postPlaylist(playlist:String, completion:(Bool, JSON?) -> Void) {
        let params = ["name":playlist]
        Alamofire.request(.POST, "\(baseURL)/playlist", parameters:params).responseJSON { (request:NSURLRequest?, response:NSHTTPURLResponse?, result:Result<AnyObject>) -> Void in
            if let json:JSON = JSON(result.value!) {
                completion(true, json)
            } else {
                completion(false, nil)
            }
        }
    }
    
    func getPlaylist(playlistID:Int, completion:(Bool, JSON?) -> Void) {
        Alamofire.request(.GET, "\(baseURL)/playlist/\(playlistID)").responseJSON { (request:NSURLRequest?, response:NSHTTPURLResponse?, result:Result<AnyObject>) -> Void in
            if let json:JSON = JSON(result.value!) {
                completion(true, json)
            } else {
                completion(false, nil)
            }
        }
    }
}
