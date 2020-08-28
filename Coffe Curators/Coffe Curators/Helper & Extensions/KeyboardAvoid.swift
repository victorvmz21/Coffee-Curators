//
//  KeyboardAvoid.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/27/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class KeyboardAvoid {
    
    static func keyboardNotifications(view: UIView) {
        
        let nc = NotificationCenter.default
        
        nc.addObserver(forName: UIResponder.keyboardWillShowNotification,
                       object: nil, queue: .main) { notification in
                        
                        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                            view.frame.origin.y = -keyboardSize.height / 2
                        }
        }
        
        nc.addObserver(forName: UIResponder.keyboardWillHideNotification,
                       object: nil, queue: .main) { _ in
                        view.frame.origin.y = 0
        }
        
    }
    
}
