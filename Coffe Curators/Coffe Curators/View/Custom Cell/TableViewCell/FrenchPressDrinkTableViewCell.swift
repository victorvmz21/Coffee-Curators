//
//  FrenchPressDrinkTableViewCell.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/25/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class FrenchPressDrinkTableViewCell: UITableViewCell {
    
    //MARK:  - IBOutlet
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    static let identifier = "FrenchPressDrinkTableViewCell"
    var coffee: [Drink] = []
    
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
extension FrenchPressDrinkTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffee.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FrenchPressDrinkCollectionViewCell.identifier, for: indexPath) as? FrenchPressDrinkCollectionViewCell else { return UICollectionViewCell()}
        
        let drink = coffee[indexPath.row]
        self.categoryLabel.text = drink.drinkCategory
        cell.frenchPressDrink = drink
        cell.addShadow()
        
        return cell
    }
}

