//
//  DripCoffeeTableViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/18/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DripCoffeeTableViewController: UITableViewController {

    //MARK: - Propertiess
    var hotDrinks:     [Drink] = []
    var coldDrinks:    [Drink] = []
    var blendedDrinks: [Drink] = []
    var selectedDrink: Drink?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }
    
    //MARK: - Methods
    func fetch() {
        DrinkController.shared.fetchDrinks { result in
            switch result {
            case .success(let drinks):
                for drink in drinks {
                    if  drink.appliance == "Drip Cofee" && drink.drinkCategory == "Hot" {
                        self.hotDrinks.append(drink)
                        print("This is Hot Drinks \(self.hotDrinks)")
                    } else if drink.appliance == "Drip Cofee" && drink.drinkCategory == "Cold" {
                        self.coldDrinks.append(drink)
                        print("This is Cold Drinks \(self.coldDrinks)")
                    } else if drink.appliance == "Drip Cofee" && drink.drinkCategory == "Blended" {
                        self.blendedDrinks.append(drink)
                        print("This is Blended Drinks \(self.blendedDrinks)")
                    }
                }
                
            case .failure(let error):
                print("can not fetch data")
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Hit number of rows")
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 242
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DripCoffeeTableViewCell.identifier, for: indexPath) as? DripCoffeeTableViewCell else { return UITableViewCell()}
        if indexPath.section == 0 {
            cell.itemTappedDelegate = self
            cell.coffee = hotDrinks
            cell.reloading()
        } else if indexPath.section == 1 {
            cell.itemTappedDelegate = self
            cell.coffee = coldDrinks
            cell.reloading()
        } else if indexPath.section == 2 {
            cell.itemTappedDelegate = self
            cell.coffee = blendedDrinks
            cell.reloading()
        }
    
        return cell
    }
    
    //Segue
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "dripToDetail" {
               guard let destination = segue.destination as? DrinkDetailScreenViewController else {return}
               destination.drinkLandingPad = selectedDrink
           }
       }
    
    
}

extension DripCoffeeTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Drip Coffee")
    }
}

extension DripCoffeeTableViewController: CollectionItemTappedDelegate {
    func itemWasTapped(drink: Drink) {
        self.selectedDrink = drink
        self.performSegue(withIdentifier: "dripToDetail", sender: nil)
    }
}
