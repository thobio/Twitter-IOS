//
//  UserService.swift
//  Twitter IOS
//
//  Created by Zerone on 11/05/20.
//  Copyright © 2020 Coding Crackers. All rights reserved.
//

import Foundation
import Firebase

struct UserService {
    static let shared = UserService()
    func fetchUser(uid:String,completion:@escaping(User) -> Void){
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {return}
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
        
    }
}



