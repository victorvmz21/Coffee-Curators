//
//  FrenchPressDrinkCollectionViewCell.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/25/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class FrenchPressDrinkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkTitle: UILabel!
    
    static let identifier = "FrenchPressDrinkCollectionViewCell"
    
    var frenchPressDrink: Drink? {
        didSet { updateCollectionViewCell() }
    }
    
    func updateCollectionViewCell() {
        guard let drink = frenchPressDrink else { return }
        self.drinkImage.image = UIImage(data: drink.drinkPicture)
        self.drinkTitle.text = drink.title
    }
}
