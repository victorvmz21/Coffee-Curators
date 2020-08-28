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
    @IBOutlet weak var sweetenerLabel: UILabel!
    @IBOutlet weak var sweetenerMeasureLabel: UILabel!
    @IBOutlet weak var sweetenerTextField: UITextField!
    @IBOutlet weak var sweetenerMeasureTextField: UITextField!
    @IBOutlet weak var sweetenerCell: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: Properties
    var drinkTitle  = ""
    var drinkType   = ""
    var image       = Data()
    var appliance   = ""
    var coffeeRoast = ""
    var coffeeShot  = ""
    var dairy       = ""
    var sweeteners  = ""
    var sweetenersMeasure = ""
    var pickerController = UIPickerView()
    var tableSponsArray: [String] = ["1 TBLSP","2 TBLSP","3 TBLSP","4 TBLSP","5 TBLSP","6 TBLSP","7 TBLSP","8 TBLSP","9 TBLSP","10 TBLSP"]
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       setupView()
          print(drinkTitle)
    }
    
    //MARK: - IBActions
    ///Sweeteners button
    @IBAction func hideCellButtonTapped(_ sender: UIButton) {
        self.sweetenerCell.isHidden = true
    }
    
    @IBAction func addSweetenerButtonTapped(_ sender: UIButton) {
        self.sweetenerTextField.isHidden = false
        self.sweetenerMeasureTextField.isHidden = false
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: - Methods
    
    func setupView() {
        self.sweetenerMeasureTextField.inputView = pickerController
        KeyboardAvoid.keyboardNotifications(view: self.view)
        self.sweetenerTextField.delegate = self
        self.sweetenerMeasureTextField.delegate = self
        self.pickerController.delegate = self
        self.sweetenerCell.isHidden = true
        self.sweetenerTextField.isHidden = true
        self.sweetenerMeasureTextField.isHidden = true
        self.sweetenerTextField.addBrowBorder()
        self.backButton.addBrowBorder()
    }
    
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
    
    func setupToolBar() {
        let toolBar = UIToolbar(frame: CGRect(origin: .zero,
                                              size: CGSize(width: view.frame.width, height: 30)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self,
                                   action: #selector(doneButtonAction))
        
        toolBar.setItems([flexSpace,done], animated: true)
        toolBar.sizeToFit()
        
        sweetenerMeasureTextField.inputAccessoryView = toolBar
    
    }
    
    @objc func doneButtonAction() {
        
        if sweetenerMeasureTextField.isFirstResponder {
            self.sweetenerTextField.isHidden = true
            self.sweetenerMeasureTextField.isHidden = true
            self.sweetenerCell.isHidden = false
            self.sweetenerMeasureTextField.resignFirstResponder()
        }
    }
}

extension DrinkSweetenerViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tableSponsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tableSponsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pickerData: String
        
        if sweetenerMeasureTextField.isFirstResponder {
            pickerData = tableSponsArray[row]
            self.sweetenerMeasureTextField.text = pickerData
            self.sweetenersMeasure = pickerData
            self.sweetenerMeasureLabel.text = pickerData
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if sweetenerTextField.isFirstResponder {
            guard let text = textField.text else { return false}
            sweetenerLabel.text = text
            sweeteners = text
            sweetenerMeasureTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setupToolBar()
    }
}
