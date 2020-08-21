//
//  DrinkInstructionsViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/17/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class DrinkInstructionsViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var instructionsTextField: UITextField!
    @IBOutlet weak var cofeeRoastLabel: UILabel!
    @IBOutlet weak var coffeeShotLabel: UILabel!
    @IBOutlet weak var dairyLabel: UILabel!
    @IBOutlet weak var sweetenerLabel: UILabel!
    @IBOutlet weak var toppingsLabel: UILabel!
    
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
    var instructions      = ""
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    func viewSetup() {
        self.cofeeRoastLabel.text = coffeeRoast
        self.coffeeShotLabel.text = "\(coffeeShot)"
        self.dairyLabel.text = dairy
        self.sweetenerLabel.text = "\(sweeteners) \(sweetenersMeasure)"
        self.toppingsLabel.text = toppings
        self.instructionsTextField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "instructionsToPost" {
            
            guard let destination = segue.destination as? PostDrinkViewController else { return }
            
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

extension DrinkInstructionsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
