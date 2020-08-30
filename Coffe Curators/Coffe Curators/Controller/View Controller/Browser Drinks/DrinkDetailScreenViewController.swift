//
//  DrinkDetailScreenViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/19/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import MessageUI

class DrinkDetailScreenViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var applianceNameLabel: UILabel!
    @IBOutlet weak var applianceLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var milkImageView: UIImageView!
    @IBOutlet weak var sweetnerImageView: UIImageView!
    @IBOutlet weak var toppingImageView: UIImageView!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var instructionView: UIView!
    @IBOutlet weak var howToLabel: UILabel!
    @IBOutlet weak var dairyTextField: UITextField!
    @IBOutlet weak var sweetnerTextField: UITextField!
    @IBOutlet weak var toppingsTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    //Landing pad
    var drinkLandingPad: Drink?

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSetup()
        setupViews()
        instructionButtonSetup()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        setupViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let dairyText = dairyTextField.text, !dairyText.isEmpty, let sweetText = sweetnerTextField.text, !sweetText.isEmpty, let toppingsText = toppingsTextField.text, !toppingsText.isEmpty else {return}
        let db = Firestore.firestore().collection("drinks")
        if let drink = drinkLandingPad {
            db.document(drink.drinkID).updateData([
                "sweetener": sweetText,
                "dairy": dairyText,
                "topping": toppingsText
            ])
            print("updated")
        }
        setupViews()
    }
    

    
    var count = 0
    var instructionCount = 1
    @IBAction func leftButtonTapped(_ sender: Any) {
        if let arrayCount = drinkLandingPad?.instructions.count, count >= arrayCount {
            instructions(index: count)
            numberLabel.text = "\(instructionCount)"
            print(count)
        }
        count -= 1
        instructionCount -= 1
        print(count)
        setupViews()
        instructionButtonSetup()
        rightButtonSetup()
    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        if let arrayCount = drinkLandingPad?.instructions.count, count <= arrayCount {
            instructions(index: count)
            numberLabel.text = "\(instructionCount)"
        }
        count += 1
        instructionCount += 1
        print(count)
        setupViews()
        instructionButtonSetup()
        rightButtonSetup()
    }
    
    func instructionButtonSetup() {
        if count == 0 {
            leftButton.isEnabled = false
        } else {
            leftButton.isEnabled = true
        }
    }
    
    func rightButtonSetup() {
        if let arrayCount = drinkLandingPad?.instructions.count {
            print(arrayCount)
            if count + 1 == arrayCount {
                rightButton.isEnabled = false
            } else {
                rightButton.isEnabled = true
            }
        }

    }
    
    func instructions(index: Int) {
        guard let drink  = drinkLandingPad else { return }
        self.numberLabel.text = "\(instructionCount)"
        self.instructionLabel.text = drink.instructions[index]
    }
    
    @IBAction func reportButtonTapped(_ sender: Any) {
        report()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        let heartEmpty = #imageLiteral(resourceName: "Heart")
        let heartFilled = #imageLiteral(resourceName: "heart-fill")
        if likeButton.currentImage == heartEmpty {
            likedByUser()
            likeButton.setImage(heartFilled, for: .normal)
        } else {
            dislikedByUser()
            likeButton.setImage(heartEmpty, for: .normal)
        }
    }
    
    // MARK: - Methods
    func report() {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "Edit Drink", style: .default) { (_) in
            print("move to edit screen")
            self.dairyTextField.isEnabled = true
            self.sweetnerTextField.isEnabled = true
            self.toppingsTextField.isEnabled = true
            self.dairyTextField.borderStyle = .roundedRect
            self.sweetnerTextField.borderStyle = .roundedRect
            self.toppingsTextField.borderStyle = .roundedRect
            self.saveButton.isHidden = false
            self.cancelButton.isHidden = false
        }
        let reportAction = UIAlertAction(title: "Report", style: .default) { (_) in
            print("report email")
            let ref = Firestore.firestore().collection("reports")
            guard let user = Auth.auth().currentUser else {return}
            if let drink = self.drinkLandingPad {
                ref.document(drink.drinkID).setData([
                    "uid": drink.drinkID,
                    "message": "Drink, \(drink.drinkID) has been reported by a user"
                ])
            }
           
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(editAction)
        controller.addAction(reportAction)
        controller.addAction(cancelAction)
        present(controller, animated: true)
    }
    
    func setupViews() {
        design()
        dairyTextField.isEnabled = false
        sweetnerTextField.isEnabled = false
        toppingsTextField.isEnabled = false
        dairyTextField.borderStyle = .none
        sweetnerTextField.borderStyle = .none
        toppingsTextField.borderStyle = .none
        saveButton.isHidden = true
        cancelButton.isHidden = true
        
        milkImageView.image = #imageLiteral(resourceName: "mil")
        sweetnerImageView.image = #imageLiteral(resourceName: "sweetner")
        toppingImageView.image = #imageLiteral(resourceName: "topping")
        instructions(index: count)
        if let drink = drinkLandingPad {
            self.drinkNameLabel.text = drink.title
            self.applianceNameLabel.text = drink.appliance
            self.drinkImageView.image = UIImage(data: drink.drinkPicture)
            self.dairyTextField.text = drink.dairy
            self.toppingsTextField.text = toppingsList()
            self.sweetnerTextField.text = "\(drink.sweetener) - \(drink.sweetenerMeasure)"
        }
    }
    
    func toppingsList() -> String {
        var toppings = ""
        if let drink = drinkLandingPad {
            for topping in drink.topping {
                for toppingMeasure in drink.toppingMeasure {
                    toppings += "\(topping) - \(toppingMeasure)\n"
                }
            }
        }
        return toppings
    }
    
    func instructionsList() -> String {
        var instructions: String = ""
        if let drink = drinkLandingPad {
            for instruction in drink.instructions {
                instructions += "\(instruction)\n"
            }
        }
        return instructions
    }
    
    
    func buttonSetup() {
        guard let drink = drinkLandingPad, let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore().collection(drinkConstants.collectionNamekey).document(drink.title).collection("likes").document(uid)
        
        db.getDocument { (document, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            
            if let document = document, document.exists {
                let image = #imageLiteral(resourceName: "heart-fill")
                self.likeButton.setImage(image, for: .normal)
            } else {
                let image = #imageLiteral(resourceName: "Heart")
                self.likeButton.setImage(image, for: .normal)
            }
        }
    }
    
    func likedByUser() {
        guard let drink = drinkLandingPad, let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore().collection(drinkConstants.collectionNamekey).document(drink.title).collection("likes").document(uid)
        
        db.getDocument { (document, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            
            if let document = document, document.exists {
                print("Already liked")
            } else {
                print("liked")
                db.setData([
                    "uid": uid
                ])
            }
        }
    }
    
    func dislikedByUser() {
        guard let drink = drinkLandingPad, let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore().collection(drinkConstants.collectionNamekey).document(drink.title).collection("likes").document(uid)
        
        db.getDocument { (document, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            
            if let document = document, document.exists {
                print("Disliked")
                db.delete()
            }
        }
    }

    func design() {
        drinkNameLabel.font = UIFont(name: Constants.petronaReg, size: 36)
        drinkNameLabel.textColor = UIColor(named: Constants.joltBlack)
        applianceLabel.font = UIFont(name: Constants.petronaReg, size: 24)
        applianceLabel.textColor = UIColor(named: Constants.joltBlack)
        applianceNameLabel.font = UIFont(name: Constants.petronaLight, size: 15)
        applianceNameLabel.textColor = UIColor(named: Constants.joltBlack)
        ingredientsLabel.font = UIFont(name: Constants.petronaReg, size: 24)
        ingredientsLabel.textColor = UIColor(named: Constants.joltBlack)
        dairyTextField.font = UIFont(name: Constants.petronaLight, size: 17)
        dairyTextField.textColor = UIColor(named: Constants.joltBlack)
        sweetnerTextField.font = UIFont(name: Constants.petronaLight, size: 17)
        sweetnerTextField.textColor = UIColor(named: Constants.joltBlack)
        toppingsTextField.font = UIFont(name: Constants.petronaLight, size: 17)
        toppingsTextField.textColor = UIColor(named: Constants.joltBlack)
        reportButton.tintColor = UIColor(named: Constants.joltBlack)
        howToLabel.font = UIFont(name: Constants.petronaReg, size: 24)
        howToLabel.textColor = UIColor(named: Constants.joltBlack)
        numberLabel.font = UIFont(name: Constants.petronaMed, size: 21)
        numberLabel.textColor = UIColor(named: Constants.joltBlack)
        instructionLabel.font = UIFont(name: Constants.petronaMed, size: 18)
        instructionLabel.textColor = UIColor(named: Constants.joltBlack)

        
    }

}

struct Constants {
    static let petronaReg = "Petrona-Regular"
    static let petronaLight = "Petrona-Light"
    static let petronaMed = "Petrona-Medium"
    static let joltBlack = "black_jolt"
}
