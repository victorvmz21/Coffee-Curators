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
extension DripCoffeeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DripCoffeeCollectionViewCell.identifier, for: indexPath) as? DripCoffeeCollectionViewCell else { return UICollectionViewCell()}
         cell.addShadow()
        if indexPath.section == 0 {
           
            self.categoryLabel.text = "Hot"
            let hot = hotCoffee[indexPath.row]
            cell.dripDrink = hot
        } else if indexPath.section == 1 {
            self.categoryLabel.text = "Cold"
            let cold = coldCoffee[indexPath.row]
            cell.dripDrink = cold
        } else {
            self.categoryLabel.text = "Blended"
            let blended = blendedCoffee[indexPath.row]
            cell.dripDrink = blended
        }
        return cell
    }
    
    
    
}

