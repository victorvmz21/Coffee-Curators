//
//  DrinkToppingsViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/17/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class DrinkToppingsViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    //MARK: Properties
    var drinkTitle        = ""
    var drinkType         = ""
    var image             = Data()
    var appliance         = ""
    var coffeeRoast       = ""
    var coffeeShot        = 0
    var dairy             = ""
    var sweeteners        = ""
    var sweetenersMeasure = ""
    var toppings          = ""
    var toppingsMeasure   = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(drinkTitle)
        print(drinkType)
        print(image)
        print(appliance)
        print(coffeeRoast)
        print(coffeeShot)
        print(dairy)
        print(sweeteners)
        print(sweetenersMeasure)
        print(toppings)
        print(toppingsMeasure)
    }
    //MARK: - IBActions
    
    
    @IBAction func whipeCreamButtonTapped(_ sender: UIButton) {
        toppings = "Whipe Cream"
    }
    
    @IBAction func cinnamonButtonTapped(_ sender: UIButton) {
        toppings = "Cinnamon"
    }
    
    @IBAction func mmButtonTapped(_ sender: UIButton) {
        toppings = "M&M"
    }
    
    @IBAction func oneTblsButtonTapped(_ sender: UIButton) {
        toppingsMeasure = "1 TBLS"
    }
    
    @IBAction func twoTblsButtonTapped(_ sender: UIButton) {
        toppingsMeasure = "2 TBLS"
    }
    
    @IBAction func threeTblsButtonTapped(_ sender: UIButton) {
        toppingsMeasure = "3 TBLS"
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toppingsToInstruction" {
            guard let destination = segue.destination as? DrinkInstructionsViewController else { return }
            
            destination.drinkTitle = drinkTitle
            destination.drinkType = drinkType
            destination.image = image
            destination.appliance = appliance
            destination.coffeeRoast = coffeeRoast
            destination.coffeeShot = coffeeShot
            destination.dairy = dairy
            destination.sweeteners = sweeteners
            destination.sweetenersMeasure = sweetenersMeasure
            destination.toppings = toppings
            destination.toppingsMeasure = toppingsMeasure
        }
    }
    
    
}
