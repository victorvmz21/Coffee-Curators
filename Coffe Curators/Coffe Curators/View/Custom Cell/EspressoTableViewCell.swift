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
    var hotCoffee     :  [Drink] = []
    var coldCoffee    : [Drink] = []
    var blendedCoffee : [Drink] = []
    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           if section == 0 {
               return hotCoffee.count
           } else if section == 1 {
               return coldCoffee.count
           } else {
               return blendedCoffee.count
           }
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EspressoCoffeeCollectionViewCell.identifier, for: indexPath) as? EspressoCoffeeCollectionViewCell else { return UICollectionViewCell()}
            cell.addShadow()
           if indexPath.section == 0 {
              
               self.categoryLabel.text = "Hot"
               let hot = hotCoffee[indexPath.row]
               cell.espressoDrink = hot
           } else if indexPath.section == 1 {
               self.categoryLabel.text = "Cold"
               let cold = coldCoffee[indexPath.row]
               cell.espressoDrink = cold
           } else {
               self.categoryLabel.text = "Blended"
               let blended = blendedCoffee[indexPath.row]
               cell.espressoDrink = blended
           }
           return cell
       }
    
}
