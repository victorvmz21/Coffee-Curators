//
//  User.swift
//  Coffe Curators
//
//  Created by Connor Holland on 8/7/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import Foundation
import Firebase

struct User: Codable {
    
    let uid: String
    var firstName: String
    var lastName: String
    var email: String
    var profilePic: String?
}


