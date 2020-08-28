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
    @IBOutlet weak var toppingsTextField: UITextField!
    @IBOutlet weak var toppingCell: UIView!
    @IBOutlet weak var toppingLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: Properties
    var drinkTitle        = ""
    var drinkType         = ""
    var image             = Data()
    var appliance         = ""
    var coffeeRoast       = ""
    var coffeeShot        = ""
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
        setupView()
    }
    //MARK: - IBActions
    
    
    @IBAction func hideCellButtonTapped(_ sender: UIButton) {
        self.toppingCell.isHidden = true
    }
    
    @IBAction func addTextFieldButtonTapped(_ sender: UIButton) {
        self.toppingsTextField.isHidden = false
        self.toppingsTextField.text = ""
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods
    
    func setupView() {
        KeyboardAvoid.keyboardNotifications(view: self.view)
        self.toppingsTextField.delegate = self
        self.toppingsTextField.isHidden = true
        self.toppingCell.isHidden = true
        toppingsTextField.addBrowBorder()
        self.backButton.addBrowBorder()
    }
    
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

extension DrinkToppingsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if  toppingsTextField.isFirstResponder {
            guard let text = textField.text else { return false }
            self.toppings = text
            self.toppingLabel.text = text
            self.toppingsTextField.isHidden = true
            self.toppingCell.isHidden = false
            toppingsTextField.resignFirstResponder()
        }
        
        return true
    }
}
