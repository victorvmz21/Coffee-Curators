//
//  MyLibraryViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/26/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import FirebaseAuth

class MyLibraryViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Properties
    var identifier = "libraryCell"
    var drinks: [Drink] = []
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
         tableViewSetup()
         fetchUserDrinks()
    }
    
    //MARK: - Methods
    func tableViewSetup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func fetchUserDrinks() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        DrinkController.shared.fetchUserDrink(uid: uid) { result in
            switch result {
            case .success(let drink):
                self.drinks.append(contentsOf: drink)
            case .failure(let error):
                print("Fetch drink error \(error) - \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension MyLibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? myDrinksTableViewCell else { return UITableViewCell()}
        
        cell.delegate = self
        let myDrinks = drinks[indexPath.row]
        cell.myDrinks = myDrinks
        
        
        return cell
    }
}

extension MyLibraryViewController: ReloadTableViewDelegate {
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    
}
