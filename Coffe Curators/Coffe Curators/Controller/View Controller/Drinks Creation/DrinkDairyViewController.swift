//
//  DrinkDairyViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/17/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class DrinkDairyViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    //MARK: Properties
    var drinkTitle  = ""
    var drinkType   = ""
    var image       = Data()
    var appliance   = ""
    var coffeeRoast = ""
    var coffeeShot  = 0
    var dairy = ""
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    //MARK: - IBActions
    @IBAction func wholeMilkButtonTapped(_ sender: UIButton) {
        dairy = "Whole milk"
    }
    
    @IBAction func oatMilkButtonTapped(_ sender: UIButton) {
        dairy = "Oat milk"
    }
    
    @IBAction func twoPercentMilkButtonTapped(_ sender: UIButton) {
        dairy = "2% milk"
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dairyToSweetner" {
            guard let destination = segue.destination as? DrinkSweetenerViewController else { return }
            
            destination.drinkTitle = drinkTitle
            destination.drinkType = drinkType
            destination.image = image
            destination.appliance = appliance
            destination.coffeeRoast = coffeeRoast
            destination.coffeeShot = coffeeShot
            destination.dairy = dairy
        }
    }
    
    
}
