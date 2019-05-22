//
//  User.swift
//  ClipIt
//
//  Created by Alex Rodriguez on 5/22/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import UIKit

class User: NSObject {
    var username: String
    var token: String
    var id: Int
    
    init(username: String, token: String, id: Int) {
        self.username = username
        self.token = token
        self.id = id
    }

}
