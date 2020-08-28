//
//  homeScreenTableViewCell.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/13/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class homeScreenTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var expandCellButton: UIButton!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bottomCellButton: UIButton!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    //MARK: - Properties
    var isCollapsed = true
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell() {
        viewBackground.addShadow()
        roundingView()
    }
    
    func roundingView() {
        self.viewBackground.layer.cornerRadius = 32
    }
    
    func hideView(isColapped: Bool) {
        if isColapped {
            self.bottomCellButton.isHidden = false
            self.arrowImageView.isHidden   = false
            self.descriptionLabel.isHidden = false
            self.imageCell.isHidden        = false
        } else {
            self.bottomCellButton.isHidden = true
            self.arrowImageView.isHidden   = true
            self.descriptionLabel.isHidden = true
            self.imageCell.isHidden        = true
        }
    }
    
    func animateButton() {
        if viewBackground.frame.height == 336 {
            self.expandCellButton.transform = CGAffineTransform(rotationAngle: .pi)
        } else {
            self.expandCellButton.transform = CGAffineTransform(rotationAngle: .pi / 2)
        }
    }
}
