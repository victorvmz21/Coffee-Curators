//
//  PopularDrinkTableViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/18/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PopularDrinkTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DrinkController.shared.fetchDrinks { (result) in
            switch result {
            case .success(_):
                print("Fetched")
                print(DrinkController.shared.drinks[0])
            case .failure(_):
                print("Failed")
            }
        }
    }
    
    // MARK: - Methods

    
//    func fetchingPopularDrinks() {
//        DrinkController.shared.fetchDrinks { result in
//            switch result {
//            case .success(let drink):
//                <#code#>
//            case .failure(_):
//                <#code#>
//            }
//        }
//    }

    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionPopularDrinksTableViewCell.identifier, for: indexPath)


        return cell
    }
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 242
    }

}
extension PopularDrinkTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Popular Drinks")
    }
}
