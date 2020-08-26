//
//  PopularDrinkCollectionViewCell.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/18/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class PopularDrinkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkTitle: UILabel!
    
    static let identifier = "PopularDrinkCollectionViewCell"
    
    var popularDrink: Drink? {
        didSet { updateCollectionViewCell() }
    }
    
    func updateCollectionViewCell() {
        guard let drink = popularDrink else { return }
        self.drinkImage.image = UIImage(data: drink.drinkPicture)
        self.drinkTitle.text = drink.title
    }
}
