//
//  TextFieldExtension.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/27/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 2.0)
        bottomLine.backgroundColor = UIColor(named: "black_jolt")?.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
}
