//
//  DrinkSweetenerViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/17/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class DrinkSweetenerViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    //MARK: Properties
    //MARK: Properties
    var drinkTitle  = ""
    var drinkType   = ""
    var image       = Data()
    var appliance   = ""
    var coffeeRoast = ""
    var coffeeShot  = 0
    var dairy = ""
    var sweeteners = ""
    var sweetenersMeasure = ""
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    //MARK: - IBActions
    ///Sweeteners button
    @IBAction func sugarButtonTapped(_ sender: UIButton) {
        sweeteners = "Sugar"
    }
    
    @IBAction func caramelButtonTapped(_ sender: UIButton) {
        sweeteners = "Caramel"
    }
    
    
    @IBAction func syrupButtonTapped(_ sender: UIButton) {
        sweeteners = "Syrup"
    }
    
    ///Measurement buttons
    @IBAction func oneTblsButtonTapped(_ sender: UIButton) {
        sweetenersMeasure = "1 TBLS"
    }
    
    @IBAction func twoTblsButtonTapped(_ sender: UIButton) {
        sweetenersMeasure = "2 TBLS"
    }
    
    @IBAction func threeTblsButtonTapped(_ sender: UIButton) {
        sweetenersMeasure = "3 TBLS"
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sweetnersToToppings" {
            guard let destination = segue.destination as? DrinkToppingsViewController else { return }
            
            destination.drinkTitle = drinkTitle
            destination.drinkType = drinkType
            destination.image = image
            destination.appliance = appliance
            destination.coffeeRoast = coffeeRoast
            destination.coffeeShot = coffeeShot
            destination.dairy = dairy
            destination.sweeteners = sweeteners
            destination.sweetenersMeasure = sweetenersMeasure
        }
    }
    
    
}
