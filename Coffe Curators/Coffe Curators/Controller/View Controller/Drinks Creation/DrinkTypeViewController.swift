//
//  DrinkTypeViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/17/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class DrinkTypeViewController: UIViewController {

    
    //MARK: - IBOutlet
    
    //MARK: Properties
    var drinkTitle = ""
    var drinkType  = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func hotDrinkButtonTapped(_ sender: UIButton) {
        drinkType = "Hot"
    }
    
    @IBAction func coldDrinkButtonTapped(_ sender: UIButton) {
        drinkType = "Cold"
    }
    
    @IBAction func blendedDrinkButtonTapped(_ sender: UIButton) {
        drinkType = "Blended"
    }
     //MARK: - Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "drinkPictureSegue" {
            guard let destination = segue.destination as? DrinkPhotoViewController else { return }
            destination.drinkTitle = drinkTitle
            destination.drinkType = drinkType
        }
    }
}
