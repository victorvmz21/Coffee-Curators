//
//  MokaPotDrinkTableViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/25/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MokaPotDrinkTableViewController: UITableViewController {
    
    //MARK: - Properties
    var hotDrinks: [Drink] = []
    var coldDrinks: [Drink] = []
    var blendedDrinks: [Drink] = []
    var selectedDrink: Drink?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           resetArraysValues()
           fetch()
       }
    
    //MARK: - MEthods
    func fetch() {
        DrinkController.shared.fetchDrinks { result in
            switch result {
            case .success(let drinks):
                for drink in drinks {
                    if  drink.appliance == "Moka Pot" && drink.drinkCategory == "Hot" {
                        self.hotDrinks.append(drink)
                        print("This is Hot Drinks \(self.hotDrinks)")
                    } else if drink.appliance == "Moka Pot" && drink.drinkCategory == "Cold" {
                        self.coldDrinks.append(drink)
                        print("This is Cold Drinks \(self.coldDrinks)")
                    } else if drink.appliance == "Moka Pot" && drink.drinkCategory == "Blended" {
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
    
    func resetArraysValues() {
        self.hotDrinks.removeAll()
        self.coldDrinks.removeAll()
        self.blendedDrinks.removeAll()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 242
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MokaPotDrinkTableViewCell.identifier, for: indexPath) as? MokaPotDrinkTableViewCell else { return UITableViewCell()}
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
   
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "mokaPotToDetail" {
                  guard let destination = segue.destination as? DrinkDetailScreenViewController else {return}
                  destination.drinkLandingPad = selectedDrink
              }
          }
  }

  extension MokaPotDrinkTableViewController: IndicatorInfoProvider {
      func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
          return IndicatorInfo(title: "Moka Pot")
      }
  }

  extension MokaPotDrinkTableViewController: CollectionItemTappedDelegate {
      func itemWasTapped(drink: Drink) {
          self.selectedDrink = drink
          self.performSegue(withIdentifier: "mokaPotToDetail", sender: nil)
      }
      
  }
