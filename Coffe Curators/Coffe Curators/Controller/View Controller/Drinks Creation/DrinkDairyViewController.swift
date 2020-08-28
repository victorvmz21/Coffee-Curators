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
    @IBOutlet weak var dairyTextField: UITextField!
    @IBOutlet weak var dairyCell: UIView!
    @IBOutlet weak var dairyTitle: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: Properties
    var drinkTitle  = ""
    var drinkType   = ""
    var image       = Data()
    var appliance   = ""
    var coffeeRoast = ""
    var coffeeShot  = ""
    var dairy = ""
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
       super.viewDidLoad()
       setupView()
       print(coffeeRoast)
          print(drinkTitle)
    }
    
    //MARK: - IBActions
    @IBAction func addDairyButtonTapped(_ sender: UIButton) {
        self.dairyTextField.isHidden = false
        self.dairyTextField.text = ""
    }
    
    @IBAction func hideCellButtonTapped(_ sender: UIButton) {
         dairyCell.isHidden = true
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: - Methods
    func setupView() {
        self.dairyTextField.delegate = self
        dairyCell.isHidden = true
        dairyTextField.isHidden = true
        KeyboardAvoid.keyboardNotifications(view: self.view)
        self.dairyTextField.addBrowBorder()
        self.backButton.addBrowBorder()
        
    }
    
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

extension DrinkDairyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if dairyTextField.isFirstResponder {
            guard let text = textField.text else { return false }
            self.dairy = text
            self.dairyTitle.text = text
            self.dairyTextField.resignFirstResponder()
            self.dairyTextField.isHidden = true
            self.dairyCell.isHidden = false
        }
        return true
    }
}
