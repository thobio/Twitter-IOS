//
//  User.swift
//  Twitter IOS
//
//  Created by Zerone on 11/05/20.
//  Copyright © 2020 Coding Crackers. All rights reserved.
//

import Foundation

struct User {
    let fullname:String
    let email:String
    var profileImageURl:URL?
    let username:String
    let uid:String
    init(uid:String,dictionary:[String:AnyObject]) {
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        if let profileImageURlString = dictionary["profileImageURl"] as? String {
             guard let url = URL(string: profileImageURlString) else {return}
            self.profileImageURl = url
        }
    }
}
