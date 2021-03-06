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

protocol EditScreenProtocol {
    func gotToDetailScreen(withDrink: Drink)
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
    var editDelegate: EditScreenProtocol?
    var delegate: ReloadTableViewDelegate?
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    

    //MARK: - IBActions
    @IBAction func optionButtonTapped(_ sender: UIButton) {
        self.optionMenuLeftContraint.constant = 10
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        guard let drink = myDrinks else { return }
        editDelegate?.gotToDetailScreen(withDrink: drink)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let drink = myDrinks else { return }
        DrinkController.shared.deleteDrink(userID: uid, drinkUID: drink.drinkID)
        delegate?.reloadTableView()
        
    }
    
    @IBAction func closeOptionMenuButtonTapped(_ sender: UIButton) {
        self.optionMenuLeftContraint.constant = -1200
    }
    
    
    //MARK: - Methods
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
