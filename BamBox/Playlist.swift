//
//  Playlist.swift
//  BamBox
//
//  Created by Phil Cole on 10/9/15.
//  Copyright © 2015 BamBox. All rights reserved.
//

import UIKit
import SwiftyJSON

public class Playlist {
    
    var id:Int = 0
    var name:String!
    var owner_token:String!
    var participant_token:String!
    var song_plays_array:[String]!
    
    
    
    convenience init(map:JSON) {
        self.init()
        id = map["id"].int!
        name = map["name"].string
        owner_token = map["owner_token"].string
        participant_token = map["participant_token"].string
    }
    
}
