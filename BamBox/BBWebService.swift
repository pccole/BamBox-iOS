
//
//  BBWebService.swift
//  BamBox
//
//  Created by Phil Cole on 7/17/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit
import Alamofire

class BBWebService: NSObject {
    
    static let shared = BBWebService()
    
    override init() {
        print("Web Service init")
    }
    
    func postPlaylist(playlist:String, success:() -> (), failure:() -> ()) {
        
    }
    
    func postPlaylist2(playlist:String, success:(done:Bool) -> (Bool), failure:() -> ()) {
        Alamofire.request(.GET, URLString: "http://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { (request, response, data, error) in
                print(request)
                print(response)
                print(error)
                if (error != nil) {
                    let trueFalse = success(done: false)
                    if trueFalse {
                        print("hi there")
                    } else {
                        print("no there")
                    }
                    failure()
                }
        }
    }
    
    func postPlaylist3(playlist:String, success:(done:Bool) -> ()) {
        
    }
    
}
