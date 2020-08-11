//
//  Drink.swift
//  Coffe Curators
//
//  Created by Connor Holland on 8/7/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import Foundation

struct Drink: Codable {
  
    var title: String
    var drinkPicture: String
    var machineType: String
    var coofeRoast:  String
    var howManyCupsOfCoffe: Int
    var dairy: String
    var swetener: String
    var topping: [String]
    var instructions: [String]
    var measurements: String
}