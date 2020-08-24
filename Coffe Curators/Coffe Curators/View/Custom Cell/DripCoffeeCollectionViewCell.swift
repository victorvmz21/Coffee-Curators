//
//  DripCoffeeCollectionViewCell.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/18/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class DripCoffeeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkTitle: UILabel!
    
    //MARK: Properties
    static let identifier = "DripCoffeeCollectionViewCell"
    
    var dripDrink: Drink? {
        didSet { updateCollectionViewCell() }
    }
    
    func updateCollectionViewCell() {
        guard let drink = dripDrink else { return }
        self.drinkImage.image = UIImage(data: drink.drinkPicture)
        self.drinkTitle.text = drink.title
    }
}
