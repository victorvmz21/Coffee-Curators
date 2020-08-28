//
//  DripCoffeeTableViewCell.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/18/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class DripCoffeeTableViewCell: UITableViewCell {
    
    //MARK:  - IBOutlet
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    static let identifier = "DripCoffeeTableViewCell"
    var coffee: [Drink] = []
    weak var itemTappedDelegate: CollectionItemTappedDelegate?
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate   = self
        collectionView.dataSource = self
        reloading()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reloading() {
        self.collectionView.reloadData()
    }
    
}
extension DripCoffeeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return coffee.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DripCoffeeCollectionViewCell.identifier, for: indexPath) as? DripCoffeeCollectionViewCell else { return UICollectionViewCell()}

        let drink = coffee[indexPath.row]
        self.categoryLabel.text = drink.drinkCategory
        cell.dripDrink = drink
        cell.addShadow()
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let drink = coffee[indexPath.row]
        itemTappedDelegate?.itemWasTapped(drink: drink)
    }
}

