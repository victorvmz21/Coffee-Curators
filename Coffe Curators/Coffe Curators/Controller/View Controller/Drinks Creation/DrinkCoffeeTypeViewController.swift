//
//  DrinkCoffeeTypeViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/17/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class DrinkCoffeeTypeViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    //MARK: Properties
    var drinkTitle = ""
    var drinkType  = ""
    var image = Data()
    var appliance = ""
    var coffeeRoast = ""
    var coffeeShot = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    //MARK: - IBActions
    ///coffee Roast
    @IBAction func lightButtonTapped(_ sender: UIButton) {
        coffeeRoast = "Light"
    }
    @IBAction func mediumButtonTapped(_ sender: UIButton) {
        coffeeRoast = "Medium"
    }
    @IBAction func darkButtonTapped(_ sender: UIButton) {
        coffeeRoast = "Dark"
    }
    @IBAction func extraDarkButtonTapped(_ sender: UIButton) {
        coffeeRoast = "Extra Dark"
    }
    
    ///coffee shots
    @IBAction func OneshotButtonTapped(_ sender: UIButton) {
        coffeeShot = 1
    }
    
    @IBAction func twoshotsButtonTapped(_ sender: UIButton) {
        coffeeShot = 2
    }
    
    @IBAction func threeshotsButtonTapped(_ sender: UIButton) {
        coffeeShot = 3
    }
    
    @IBAction func fourshotsButtonTapped(_ sender: UIButton) {
        coffeeShot = 4
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "coffeeToDairy" {
            guard let destination = segue.destination as? DrinkDairyViewController else { return }
            
            destination.drinkTitle = drinkTitle
            destination.drinkType = drinkType
            destination.image = image
            destination.appliance = appliance
            destination.coffeeRoast = coffeeRoast
            destination.coffeeShot = coffeeShot
        }
    }
}
