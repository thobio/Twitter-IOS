//
//  Constant.swift
//  Twitter IOS
//
//  Created by Zerone on 10/05/20.
//  Copyright © 2020 Coding Crackers. All rights reserved.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_image")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("Tweets")
