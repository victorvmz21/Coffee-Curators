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
    @IBOutlet weak var coffeeRoastTextField: UITextField!
    @IBOutlet weak var coffeeShotTextField: UITextField!
    @IBOutlet weak var coffeeCell: UIView!
    @IBOutlet weak var cofeeCellLabel: UILabel!
    @IBOutlet weak var shotsLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: Properties
    var drinkTitle = ""
    var drinkType  = ""
    var image = Data()
    var appliance = ""
    var coffeeRoast = ""
    var coffeeShot = ""
    var coffeeRoastArray: [String] = ["Light", "Medium", "Dark", "Extra Dark"]
    var coffeeShotsArray: [String] = ["1 Shot", "2 Shots", "3 Shots", "4 Shots", "5 Shots", "6 Shots", "7 Shots", "8 Shots", "9 Shots", "10 Shots"]
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
          print(drinkTitle)
    }
    
    //MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func addCoffeeRoastButtonTapped(_ sender: UIButton) {
        self.coffeeRoastTextField.isHidden  = false
        self.coffeeShotTextField.isHidden   = false
    }
    
    @IBAction func hideCellButtonTapped(_ sender: UIButton) {
        self.coffeeCell.isHidden = true
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods
    func setupView() {
        self.coffeeRoastTextField.delegate  = self
        self.coffeeShotTextField.delegate   = self
        self.pickerView.delegate            = self
        self.coffeeRoastTextField.isHidden  = true
        self.coffeeShotTextField.isHidden   = true
        self.coffeeCell.isHidden            = true
        self.coffeeRoastTextField.inputView = pickerView
        self.coffeeShotTextField.inputView  = pickerView
        self.backButton.addBrowBorder()
        KeyboardAvoid.keyboardNotifications(view: self.view)
    }
    
    func setupToolBar() {
        let toolBar = UIToolbar(frame: CGRect(origin: .zero,
                                              size: CGSize(width: view.frame.width, height: 30)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self,
                                   action: #selector(doneButtonAction))
        
        toolBar.setItems([flexSpace,done], animated: true)
        toolBar.sizeToFit()
        
        coffeeRoastTextField.inputAccessoryView = toolBar
        coffeeShotTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonAction() {
        
        if coffeeRoastTextField.isFirstResponder {
            self.coffeeRoastTextField.resignFirstResponder()
            coffeeShotTextField.becomeFirstResponder()
        } else if coffeeShotTextField.isFirstResponder {
            self.coffeeShotTextField.resignFirstResponder()
            self.coffeeShotTextField.isHidden = true
            self.coffeeRoastTextField.isHidden = true
            self.coffeeCell.isHidden = false
            self.coffeeRoastTextField.text = ""
            self.coffeeShotTextField.text = ""
        }
        
    }
    
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

extension DrinkCoffeeTypeViewController: UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if coffeeRoastTextField.isFirstResponder {
            return coffeeRoastArray.count
        } else {
            return coffeeShotsArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if coffeeRoastTextField.isFirstResponder {
            return coffeeRoastArray[row]
        } else {
            return coffeeShotsArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let coffeeRoast: String
        let coffeeShot: String
        
        if coffeeRoastTextField.isFirstResponder {
            coffeeRoast = coffeeRoastArray[row]
            coffeeRoastTextField.text = coffeeRoast
            self.cofeeCellLabel.text = coffeeRoast
            self.coffeeRoast = coffeeRoast
        } else if coffeeShotTextField.isFirstResponder {
            coffeeShot = coffeeShotsArray[row]
            coffeeShotTextField.text = coffeeShot
            self.shotsLabel.text = coffeeShot
            self.coffeeShot = coffeeShot
        }
        
       
    }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            setupToolBar()
        }
        
}
