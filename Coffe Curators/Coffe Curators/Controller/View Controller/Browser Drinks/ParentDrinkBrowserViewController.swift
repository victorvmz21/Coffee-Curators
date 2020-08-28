//
//  ParentDrinkBrowserViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/18/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FirebaseAuth

class ParentDrinkBrowserViewController: ButtonBarPagerTabStripViewController {
    
    //MARK: - IBOutlets

    @IBOutlet weak var menuLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuBackgroundView: UIView!

    
    //MARK: - Properties
    var isSearchBarHidden = true
    
    override func viewDidLoad() {
        menuSetup()
        super.viewDidLoad()
        viewsSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
         self.menuLeftConstraint.constant = -self.view.frame.size.width
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
        self.menuLeftConstraint.constant = -self.view.frame.size.width
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
       let tabBarController = UIApplication.shared.windows.first?.rootViewController as? UITabBarController
       tabBarController?.selectedIndex = 0
    }
    
    @IBAction func makeNewCreatttionButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DrinkCreation", bundle: nil)
        let createDrinkVC = storyboard.instantiateViewController(identifier: "drinkTitle")
        self.present(createDrinkVC, animated: true, completion: nil)
    }
    
    @IBAction func myLibraryButtonTapped(_ sender: UIButton) {
       let tabBarController = UIApplication.shared.windows.first?.rootViewController as? UITabBarController
       tabBarController?.selectedIndex = 1
    }
    
    @IBAction func personalSettingsButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createDrinkVC = storyboard.instantiateViewController(identifier: "profile")
        self.present(createDrinkVC, animated: true, completion: nil)
    }
    
    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            
        }
    }
    
    
    
    
}
