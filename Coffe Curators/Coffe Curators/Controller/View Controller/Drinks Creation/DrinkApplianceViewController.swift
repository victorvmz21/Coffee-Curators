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
    @IBOutlet weak var applianceCell: UIView!
    @IBOutlet weak var applianceTextField: UITextField!
    @IBOutlet weak var applianceCellLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: Properties
    var drinkTitle = ""
    var drinkType  = ""
    var image = Data()
    var appliance = ""
    let pickerView = UIPickerView()
    var appliances:[String] = ["Popular", "Drip Coffee", "Espresso Coffee", "Pour Over", "French Press", "Cold brew", "Moka Pot"]
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
          print(drinkTitle)
    }
    
    //MARK: - IBActions
    @IBAction func addApplianceButtonTapped(_ sender: UIButton) {
        self.applianceTextField.isHidden = false
    }
    
    @IBAction func closeCellButtonTapped(_ sender: UIButton) {
        self.applianceCell.isHidden = true
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods
    func viewSetup() {
        self.applianceCell.isHidden = true
        self.applianceTextField.isHidden = true
        self.applianceTextField.addBrowBorder()
        pickerView.delegate = self
        pickerView.dataSource = self
        self.applianceTextField.inputView = pickerView
        self.applianceTextField.delegate = self
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
        
        applianceTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonAction() {
        self.applianceTextField.resignFirstResponder()
        self.applianceTextField.isHidden = true
        self.applianceCell.isHidden = false
        self.applianceTextField.text = ""
    }
    
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

extension DrinkApplianceViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appliances.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return appliances[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pickedData: String
        pickedData = appliances[row]
        self.applianceTextField.text = pickedData
        self.applianceCellLabel.text = self.applianceTextField.text
        self.appliance = pickedData
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setupToolBar()
    }
}
