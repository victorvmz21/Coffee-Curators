//
//  ViewExtension.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/13/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 3
        self.layer.masksToBounds = false
    }
    
    func roundEdges() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    func roundPartialEdges() {
        self.layer.cornerRadius = 15
    }
    
    func addBottomOrangeBorder() {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: self.frame.size.height-1, width: self.frame.width, height: 3.0)
        bottomBorder.backgroundColor = UIColor(named: "orange_jolt")?.cgColor
        self.layer.addSublayer(bottomBorder)
    }
    
    func hideBorder() {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: self.frame.size.height-1, width: self.frame.width, height: 3.0)
        bottomBorder.backgroundColor = UIColor.white.cgColor
        self.layer.addSublayer(bottomBorder)
    }
    
    func addBrowBorder() {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: self.frame.size.height-4, width: self.frame.width, height: 3.0)
        bottomBorder.backgroundColor = UIColor(named: "black_jolt")?.cgColor
        self.layer.addSublayer(bottomBorder)
    }
}
