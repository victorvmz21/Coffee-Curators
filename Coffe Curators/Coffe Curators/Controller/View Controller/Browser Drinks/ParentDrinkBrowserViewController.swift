//
//  ParentDrinkBrowserViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/18/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ParentDrinkBrowserViewController: ButtonBarPagerTabStripViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var slideMenuTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuButtonsTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var menuBackgroundView: UIView!
    
    //MARK: - Properties
    var isSearchBarHidden = true
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        menuSetup()
        super.viewDidLoad()
        viewsSetup()
    }
    
    //MARK: - Methods
    func menuSetup() {
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = UIColor(named: "orange_jolt")!
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.font = UIFont(name: "petrona", size: 16)
            newCell?.label.font = .boldSystemFont(ofSize: 16)
            oldCell?.label.textColor = UIColor(named: "black_jolt")
            newCell?.label.textColor = UIColor(named: "black_jolt")
        }
    }
    
    func viewsSetup() {
        self.searchBar.isHidden = true
        self.slideMenuTopConstraint.constant = -30
        self.menuLeftConstraint.constant = -self.view.frame.size.width
        self.signInButton.roundEdges()
        self.signUpButton.roundEdges()
        self.menuBackgroundView.addShadow()
    }
    
    //Adding View to Slide Menu
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "BrowserDrinks", bundle: nil).instantiateViewController(withIdentifier: "child1")
        let child_2 = UIStoryboard(name: "BrowserDrinks", bundle: nil).instantiateViewController(withIdentifier: "child2")
        let child_3 = UIStoryboard(name: "BrowserDrinks", bundle: nil).instantiateViewController(withIdentifier: "child3")
        let child_4 = UIStoryboard(name: "BrowserDrinks", bundle: nil).instantiateViewController(withIdentifier: "child4")
        let child_5 = UIStoryboard(name: "BrowserDrinks", bundle: nil).instantiateViewController(withIdentifier: "child5")
        let child_6 = UIStoryboard(name: "BrowserDrinks", bundle: nil).instantiateViewController(withIdentifier: "child6")
        let child_7 = UIStoryboard(name: "BrowserDrinks", bundle: nil).instantiateViewController(withIdentifier: "child7")
        
        return [child_1, child_2, child_3, child_4, child_5, child_6, child_7]
    }
    
    //MARK: - IBActions
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        isSearchBarHidden = !isSearchBarHidden
        self.searchBar.isHidden = isSearchBarHidden
        self.slideMenuTopConstraint.constant = isSearchBarHidden ? -30 : 10
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.4) {
            self.menuLeftConstraint.constant = 20
        }
    }
    
    @IBAction func closeMenuButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.4) {
            self.menuLeftConstraint.constant = -self.view.frame.size.width
        }
    }
    
    //MARK: - MENU BUTTONS
    @IBAction func homeMenuButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func makeNewCreatttionButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        let storyboard = UIStoryboard(name: "DrinkCreation", bundle: nil)
        let createDrinkVC = storyboard.instantiateViewController(identifier: "drinkTitle")
        self.navigationController?.pushViewController(createDrinkVC, animated: true)
    }
    
    @IBAction func myLibraryButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "BrowserDrinks", bundle: nil)
        let myLibraryVC = storyboard.instantiateViewController(identifier: "myLibrary")
        self.navigationController?.pushViewController(myLibraryVC, animated: true)
    }
    
    @IBAction func personalSettingsButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        let storyboard = UIStoryboard(name: "main", bundle: nil)
        let createDrinkVC = storyboard.instantiateViewController(identifier: "profile")
        self.navigationController?.pushViewController(createDrinkVC, animated: true)
    }
    
}
