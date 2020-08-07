//
//  User.swift
//  Coffe Curators
//
//  Created by Connor Holland on 8/7/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import Foundation

struct User {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var profilePic: String?
    var favorites: [Drink]?
    var comments: [Comment]?
}

struct Comment {
    var comment: String
}

