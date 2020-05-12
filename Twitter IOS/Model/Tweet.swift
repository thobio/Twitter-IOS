//
//  Tweet.swift
//  Twitter IOS
//
//  Created by Zerone on 11/05/20.
//  Copyright © 2020 Coding Crackers. All rights reserved.
//

import Foundation
struct Tweet {
    let caption:String
    let tweetID:String
    let uid:String
    let likes:Int
    let retweetCount:Int
    var timestamp:Date!
    let user:User
    init(user:User,tweetId:String,dictionary: [String:Any]) {
        self.tweetID = tweetId
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount = dictionary["retweets"] as? Int ?? 0
        if let timestamp = dictionary["timestamp"] as? Double{
             self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
       
        
    }
}
