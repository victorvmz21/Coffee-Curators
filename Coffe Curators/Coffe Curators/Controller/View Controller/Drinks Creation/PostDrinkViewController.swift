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
    @IBOutlet weak var deleteDrink: UIButton!
    @IBOutlet weak var drinkMainLabel: UILabel!
    
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
        setupView()
    }
    
    //MARK: - IBActions
    @IBAction func post(_ sender: UIButton) {
        savePost()
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelDrinkPostButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: - Methods
    func savePost() {
        guard let uID = Auth.auth().currentUser?.uid else {
            print("user not logged in")
            return }
        DrinkController.shared.createDrink(viewcontroller: self, userId: uID, title: drinkTitle, drinkCategory: drinkType, drinkPicture: image, appliance: appliance, coofeRoast: coffeeRoast, coffeeShot: coffeeShot, dairy: dairy, sweetener: sweeteners, sweetenerMeasure: sweetenersMeasure, topping: [toppings], toppingMeasure: [toppingsMeasure])
        
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupView() {
        deleteDrink.addBrowBorder()
        drinkMainLabel.text = "Do you want to post \n \(drinkTitle)"
    }
    
}
