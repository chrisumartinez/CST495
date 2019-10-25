//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Chris Martinez on 10/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class User {

    var name: String?
    var screenName : String?
    static var current : User!
    var profilepic : URL?

    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profilepic = dictionary["profile_image_url_https"] as? URL
        if let profile = dictionary["profile_image_url_https"] as? String {
            profilepic = URL(string: profile)!
        }
    }
}
