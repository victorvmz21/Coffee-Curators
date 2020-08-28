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
    }
    
    func roundEdges() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
