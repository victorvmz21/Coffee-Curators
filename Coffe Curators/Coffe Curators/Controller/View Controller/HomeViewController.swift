//
//  HomeViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/13/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    //MARK: - Properties
    let reusableIdentifier = "coffeeType"
    var selectedIndex = IndexPath(row: 0, section: 0)
    var isFirstRun = true
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        setupViews()
        customMenu()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - IBActions
    @IBAction func newCreationButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func BrowserDrinksButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func hamburguerMenuButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.menuLeftConstraint.constant = 14
        }
    }
    
    @IBAction func dismissMenuButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.menuLeftConstraint.constant = -self.view.frame.size.width
        }
    }
    
    //MARK: -  MENU sign in and sign up IBAction
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
    }
    
    ///Menu IBAction
    @IBAction func homeButtonTapped(_ sender: UIButton) {
    }
    @IBAction func browserDrinksButtonTapped(_ sender: UIButton) {
    }
    @IBAction func makeNewCreationButtonTapped(_ sender: UIButton) {
    }
    @IBAction func myLibraryButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func personalSettingsButtonTapped(_ sender: UIButton) {
    }
    
    //MARK: - Methods
    func tableViewSetup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setupViews() {
        self.mainTitleLabel.text = "Learn more about \n coffee"
        self.signInButton.roundEdges()
        self.signUpButton.roundEdges()
    }
    
    func customMenu() {
        menuView.clipsToBounds = false
        menuView.addShadow()
        menuLeftConstraint.constant = -self.view.frame.size.width
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as? homeScreenTableViewCell else { return UITableViewCell() }
        
        if isFirstRun && indexPath.row == 0 {
            cell.expandCellButton.transform = CGAffineTransform.init(rotationAngle: .pi)
            isFirstRun = false
        }
        
        if cell.viewBackground.frame.height == 336 {
            cell.hideView(isColapped: false)
        } else { cell.hideView(isColapped: true) }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath {return 336}
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Update previously selected cell
        let currentCell = tableView.cellForRow(at: selectedIndex) as? homeScreenTableViewCell
        UIView.animate(withDuration: 0.4) {
            currentCell?.expandCellButton.transform = .identity
        }
        
        //Update newly selected cell
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as? homeScreenTableViewCell
        UIView.animate(withDuration: 0.4) {
            cell?.expandCellButton.transform = CGAffineTransform.init(rotationAngle: .pi / 1)
        }
        
        selectedIndex = indexPath
        tableView.beginUpdates()
        tableView.reloadRows(at: [selectedIndex], with: .none)
        tableView.endUpdates()
    }
}