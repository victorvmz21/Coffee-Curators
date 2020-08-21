//
//  PostDrinkViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/17/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import FirebaseAuth

class PostDrinkViewController: UIViewController {
    
    //MARK: - IBOutlet
    
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
    }
    
    //MARK: - IBActions
    @IBAction func post(_ sender: UIButton) {
        savePost()
    }
    
    @IBAction func cancelDrinkPostButtonTapped(_ sender: UIButton) {
        navigationController?.dismiss(animated: false, completion: nil)
    }
    
    //MARK: - Methods
    func savePost() {
        guard let uID = Auth.auth().currentUser?.uid else {
            print("user not logged in")
            return }
        DrinkController.shared.createDrink(userId: uID, title: drinkTitle, drinkCategory: drinkType, drinkPicture: image, appliance: appliance, coofeRoast: coffeeRoast, coffeeShot: coffeeShot, dairy: dairy, sweetener: sweeteners, sweetenerMeasure: sweetenersMeasure, topping: [toppings], toppingMeasure: [toppingsMeasure], instructions: [instructions])
        
        navigationController?.dismiss(animated: false, completion: nil)
        
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
