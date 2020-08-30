//
//  MyLibraryViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/26/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import FirebaseAuth

class MyLibraryViewController: UIViewController, EditScreenProtocol {
    
    

    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Properties
    var identifier = "libraryCell"
    var drinks: [Drink] = []
    var selectedDrink: Drink?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        drinks.removeAll()
        fetchUserDrinks()
        tableView.reloadData()
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
    
    func gotToDetailScreen(withDrink: Drink) {
        selectedDrink = withDrink
        performSegue(withIdentifier: "editToDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editToDetail" {
            guard let destination = segue.destination as? DrinkDetailScreenViewController else {return}
            
            destination.drinkLandingPad = selectedDrink
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedDrink = selectedDrink else { return }
        gotToDetailScreen(withDrink: selectedDrink)
    }
}

extension MyLibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? myDrinksTableViewCell else { return UITableViewCell()}
        
        cell.delegate = self
        cell.editDelegate = self
        let myDrinks = drinks[indexPath.row]
        cell.myDrinks = myDrinks
        
        
        return cell
    }
}

extension MyLibraryViewController: ReloadTableViewDelegate {
    func reloadTableView() {
        self.drinks.removeAll()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        fetchUserDrinks()
    }
}

