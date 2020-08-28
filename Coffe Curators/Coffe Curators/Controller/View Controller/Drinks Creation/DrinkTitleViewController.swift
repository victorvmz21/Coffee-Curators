//
//  DrinkTitleViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/17/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class DrinkTitleViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var advanceButton: UIButton!
    //MARK: Properties
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        titleTextField.addBottomBorder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods
    func viewSetup() {
        self.titleTextField.delegate = self
        textFieldValidation()
        KeyboardAvoid.keyboardNotifications(view: self.view)
    }
    
    func textFieldValidation() {
        if titleTextField.text!.isEmpty {
            advanceButton.isEnabled = false
            advanceButton.backgroundColor = .lightGray
        } else {
            advanceButton.isEnabled = true
            advanceButton.backgroundColor = UIColor(named: "orange_jolt")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "drinkType" {
            guard let destination  = segue.destination as? DrinkTypeViewController else { return }
            guard let drinkTitle = titleTextField.text else { return }
            destination.drinkTitle = drinkTitle
        }
    }
}

extension DrinkTitleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldValidation()
    }
}
