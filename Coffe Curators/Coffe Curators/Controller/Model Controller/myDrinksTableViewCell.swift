//
//  myDrinksTableViewCell.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/26/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol ReloadTableViewDelegate {
    func reloadTableView()
}

class myDrinksTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkTitleLabel: UILabel!
    @IBOutlet weak var applianceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var optionMenuLeftContraint: NSLayoutConstraint!
    @IBOutlet weak var optionViewBackground: UIStackView!
    
    //MARK: - Properties
    var myDrinks: Drink? {
        didSet{ updateViews() }
    }
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    var delegate: ReloadTableViewDelegate?

    //MARK: - IBActions
    @IBAction func optionButtonTapped(_ sender: UIButton) {
        self.optionMenuLeftContraint.constant = 10
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let drink = myDrinks else { return }
        DrinkController.shared.deleteDrink(userID: uid, drinkUID: drink.drinkID)
//        deleteAlert()
        delegate?.reloadTableView()
        
    }
    
    @IBAction func closeOptionMenuButtonTapped(_ sender: UIButton) {
        self.optionMenuLeftContraint.constant = -1200
    }
    
    
    //MARK: - Methods
//    func deleteAlert() {
//        let controller = UIAlertController(title: "Delete?", message: "Are you sure you want to delete this drink?", preferredStyle: .alert)
//        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (_) in
//            print("Deleted")
//            guard let uid = Auth.auth().currentUser?.uid else { return }
//            guard let drink = self.myDrinks else { return }
//            DrinkController.shared.deleteDrink(userID: uid, drinkUID: drink.drinkID)
//            self.delegate?.reloadTableView()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        controller.addAction(deleteAction)
//        controller.addAction(cancelAction)
//        MyLibraryViewController().present(controller, animated: true)
//    }
    
    func updateViews() {
        guard let mydrinks = myDrinks else { return }
        self.drinkImage.image = UIImage(data: mydrinks.drinkPicture)
        self.drinkTitleLabel.text = mydrinks.title
        self.applianceLabel.text = mydrinks.appliance
        self.categoryLabel.text = mydrinks.drinkCategory
    }
    
    func setupView() {
        self.optionMenuLeftContraint.constant = -1200
    }

}
