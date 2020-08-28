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
    @IBOutlet weak var hotButton: UIButton!
    @IBOutlet weak var coldButton: UIButton!
    @IBOutlet weak var blendedButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: Properties
    var drinkTitle = ""
    var drinkType  = ""
    var isButtonSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.addBrowBorder()
        print(drinkTitle)
    }
    
    //MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
       self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func hotDrinkButtonTapped(_ sender: UIButton) {
        addBorder()
        drinkType = "Hot"
    }
    
    @IBAction func coldDrinkButtonTapped(_ sender: UIButton) {
       addBorder()
       drinkType = "Cold"
    }
    
    @IBAction func blendedDrinkButtonTapped(_ sender: UIButton) {
        addBorder()
        drinkType = "Blended"
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods
    func addBorder() {
        if hotButton.isHighlighted {
            hotButton.addBottomOrangeBorder()
            coldButton.hideBorder()
            blendedButton.hideBorder()
        } else if coldButton.isHighlighted {
            coldButton.addBottomOrangeBorder()
            hotButton.hideBorder()
            blendedButton.hideBorder()
        } else if blendedButton.isHighlighted {
             blendedButton.addBottomOrangeBorder()
            coldButton.hideBorder()
            hotButton.hideBorder()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "drinkPictureSegue" {
            guard let destination = segue.destination as? DrinkPhotoViewController else { return }
            destination.drinkTitle = drinkTitle
            destination.drinkType = drinkType
        }
    }
}
