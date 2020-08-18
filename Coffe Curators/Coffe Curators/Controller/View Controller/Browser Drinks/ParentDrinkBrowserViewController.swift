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

   
      override func viewDidLoad() {
      // change selected bar color
      menuSetup()
      super.viewDidLoad()
      }
      
    //MARK: - Methods
    func menuSetup() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
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
          newCell?.label.font = .boldSystemFont(ofSize: 18)
          oldCell?.label.textColor = UIColor(named: "black_jolt")
          newCell?.label.textColor = UIColor(named: "black_jolt")
        }
    }
    
    //Adding View to Slide Menu
      override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
      let child_1 = UIStoryboard(name: "BrowserDrinks", bundle: nil).instantiateViewController(withIdentifier: "child1")
      let child_2 = UIStoryboard(name: "BrowserDrinks", bundle: nil).instantiateViewController(withIdentifier: "child2")
        let child_3 = UIStoryboard(name: "BrowserDrinks", bundle: nil).instantiateViewController(withIdentifier: "child3")
      return [child_1, child_2, child_3]
      }
    
    //MARK: - IBActions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
