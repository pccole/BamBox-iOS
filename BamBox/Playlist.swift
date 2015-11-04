//
//  Playlist.swift
//  BamBox
//
//  Created by Phil Cole on 10/9/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit

public class Playlist {
    
    var id:Int = 0
    var name:String!
    var owner_token:String!
    var participant_token:String!
    var song_plays_array:[String]!
    
    
    
    convenience init(dictionary:[String:AnyObject]) {
        self.init()
        guard id = dictionary["id"] as! Int else {
            
        }
        name = "hi"
        owner_token = "hi"
        participant_token = "hi"
        song_plays_array = [String]()
    }
    
}
