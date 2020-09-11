//
//  homeScreenData.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/26/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

struct homeScreenData {
    
    var title: String
    var image: UIImage
    var description: String
    var storyboardName: String
    var storyboardID: String
}

class MainData {
    
    static var contentArray: [homeScreenData] {
        let dripCoffee = homeScreenData(title: "Drip Coffee", image: #imageLiteral(resourceName: "dripCoffee"), description: "Drip coffee is made by dripping boiling water over ground coffee, which is ground more coarsely than espresso coffee. The water filters through the coffee and falls into a pot. This process is slower than the espresso process, and hot.", storyboardName: "BrowserDrinks", storyboardID: "child2")
        
        let espresso = homeScreenData(title: "Espresso", image: #imageLiteral(resourceName: "espresso"), description: "Orginated in Italy, Espresso tends to be thicker than other methods of coffee making. Its known for it’s creame (Foam) after a shot is pulled.", storyboardName: "BrowserDrinks", storyboardID: "child3")
        
        let pourOver = homeScreenData(title: "Pour Over", image: #imageLiteral(resourceName: "pourOver"), description: "Pour over Coffee is made by pouring hot water over finely ground beans. Tends have more vibrant flavors than drip coffee because it has more time to pull flavors from the grounds.", storyboardName: "BrowserDrinks", storyboardID: "child4")
        
        let frenchPress = homeScreenData(title: "French Press", image: #imageLiteral(resourceName: "frenchPress"), description: "The French Press uses pressure to force coffee to the bottom of an elegant pot after brewing, capturing the concentrated flavors. This is coffee in its purest form. The results are deep; dark and full flavored.", storyboardName: "BrowserDrinks", storyboardID: "child5")
        
        let coldBrew = homeScreenData(title: "Cold Brew", image: #imageLiteral(resourceName: "coldBrew"), description: "Cold brew is really as simple as mixing ground coffee with cool water and steeping the mixture in the fridge overnight. The next day you strain the mixture, leaving you with a concentrate.", storyboardName: "BrowserDrinks", storyboardID: "child6")
        
        let mokaPot = homeScreenData(title: "Moka Pot", image: #imageLiteral(resourceName: "coffee"), description: "The Moka Pot is a stove-top or electric coffee maker that brews coffee by passing boiling water pressurized by steam through ground coffee.", storyboardName: "BrowserDrinks", storyboardID: "child7")
        
        return [dripCoffee, espresso, pourOver, frenchPress, coldBrew, mokaPot]
    }
}
