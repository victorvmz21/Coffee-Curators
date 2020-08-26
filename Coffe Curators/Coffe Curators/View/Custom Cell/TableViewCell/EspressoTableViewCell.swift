//
//  EspressoTableViewCell.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/19/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class EspressoTableViewCell: UITableViewCell {
    
    //MARK:  - IBOutlet
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    static let identifier = "EspressoTableViewCell"
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

extension EspressoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffee.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EspressoCoffeeCollectionViewCell.identifier, for: indexPath) as? EspressoCoffeeCollectionViewCell else { return UICollectionViewCell()}
        
        
        let hot = coffee[indexPath.row]
        self.categoryLabel.text = hot.drinkCategory
        cell.espressoDrink = hot
        cell.addShadow()
        
        return cell
    }
    
}
