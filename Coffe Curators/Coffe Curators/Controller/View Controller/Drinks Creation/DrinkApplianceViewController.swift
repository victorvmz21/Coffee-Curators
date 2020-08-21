//
//  DrinkApplianceViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/17/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class DrinkApplianceViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    //MARK: Properties
    var drinkTitle = ""
    var drinkType  = ""
    var image = Data()
    var appliance = ""
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(image)
    }
    
    //MARK: - IBActions
    @IBAction func dripButtonTapped(_ sender: UIButton) {
        appliance = "Drip"
    }
    @IBAction func espressoButtonTapped(_ sender: UIButton) {
        appliance = "Espresso"
    }
    @IBAction func pourOverButtonTapped(_ sender: UIButton) {
        appliance = "Pour Over"
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
       }
    //MARK: - Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "applianceToCoffeeType" {
            guard let destination = segue.destination as? DrinkCoffeeTypeViewController else { return }
            
            destination.drinkTitle = drinkTitle
            destination.drinkType = drinkType
            destination.image = image
            destination.appliance = appliance
        }
    }
}
