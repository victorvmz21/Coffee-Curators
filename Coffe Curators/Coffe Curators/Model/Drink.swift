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
    var drinkCategory: String
    var drinkPicture: Data
    var appliance: String
    var coofeRoast:  String
    var coffeeShot: Int
    var dairy: String
    var sweetener: String
    var sweetenerMeasure: String
    var topping: [String]
    var toppingMeasure: [String]
    var instructions: [String]
    var drinkID: String
}
