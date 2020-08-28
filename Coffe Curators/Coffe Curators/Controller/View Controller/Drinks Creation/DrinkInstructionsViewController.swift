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
    @IBOutlet weak var cofeeRoastLabel: UILabel!
    @IBOutlet weak var coffeeShotLabel: UILabel!
    @IBOutlet weak var dairyLabel: UILabel!
    @IBOutlet weak var sweetenerLabel: UILabel!
    @IBOutlet weak var toppingsLabel: UILabel!
    @IBOutlet weak var instructionTextField: UITextField!
    @IBOutlet weak var instructionCell01: UIView!
    @IBOutlet weak var instructionCell02: UIView!
    @IBOutlet weak var instructionCell03: UIView!
    @IBOutlet weak var labelInstruction01: UILabel!
    @IBOutlet weak var labelInstruction02: UILabel!
    @IBOutlet weak var labelInstruction03: UILabel!
    @IBOutlet weak var numberOneButton: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    
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
    var instructions: [String] = []
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        print(drinkTitle)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - IBActions
    
    @IBAction func addTextFieldButtonTapped(_ sender: UIButton) {
        self.instructionTextField.isHidden = false
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func closeButtoncellOneTapped(_ sender: UIButton) {
        self.instructionCell01.isHidden = true
        self.instructions.removeFirst()
    }
    
    @IBAction func closeButtoncellTwoTapped(_ sender: UIButton) {
        self.instructionCell02.isHidden = true
        self.instructions.remove(at: 1)
    }
    
    @IBAction func closeButtoncellThreeTapped(_ sender: UIButton) {
        self.instructionCell03.isHidden = true
        self.instructions.removeLast()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods
    func viewSetup() {
        KeyboardAvoid.keyboardNotifications(view: self.view)
        self.cofeeRoastLabel.text = coffeeRoast
        self.coffeeShotLabel.text = coffeeShot
        self.dairyLabel.text = dairy
        self.sweetenerLabel.text = "\(sweeteners) \(sweetenersMeasure)"
        self.toppingsLabel.text = toppings
        self.instructionTextField.delegate = self
        self.instructionTextField.isHidden = true
        self.instructionCell01.isHidden = true
        self.instructionCell02.isHidden = true
        self.instructionCell03.isHidden = true
        self.instructionTextField.addBrowBorder()
        self.numberOneButton.roundEdges()
        self.buttonTwo.roundEdges()
        self.buttonThree.roundEdges()
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
            destination.instructions = instructions
        }
    }
    
}

extension DrinkInstructionsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if instructionTextField.isFirstResponder {
            guard let text = textField.text else { return false }
            self.instructions.append(text)
            
            if instructions.count == 1 {
                self.instructionCell01.isHidden = false
                self.labelInstruction01.text = instructions[0]
                
            } else if instructions.count == 2 {
                self.instructionCell02.isHidden = false
                self.labelInstruction02.text = instructions[1]
            } else if instructions.count == 3 {
                self.instructionCell03.isHidden = false
                self.labelInstruction03.text = instructions[2]
                self.instructionTextField.isHidden = true
            }
            textField.resignFirstResponder()
            textField.text = ""
        }
        return true
    }
}
