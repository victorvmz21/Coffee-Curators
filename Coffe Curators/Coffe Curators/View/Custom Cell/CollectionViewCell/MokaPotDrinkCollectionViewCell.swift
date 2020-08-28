//
//  MokaPotDrinkCollectionViewCell.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/25/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class MokaPotDrinkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkTitle: UILabel!
    
    static let identifier = "MokaPotDrinkCollectionViewCell"
    
    var mokaPotDrink: Drink? {
        didSet { updateCollectionViewCell() }
    }
    
    func updateCollectionViewCell() {
        guard let drink = mokaPotDrink else { return }
        self.drinkImage.image = UIImage(data: drink.drinkPicture)
        self.drinkTitle.text = drink.title
    }
}
