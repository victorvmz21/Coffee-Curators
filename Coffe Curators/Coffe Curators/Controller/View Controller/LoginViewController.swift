//
//  LoginViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/11/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
       textFieldSetup()
    }
    
    //MARK: - IBActions
    @IBAction func backButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(identifier: "homeScreen") as? HomeViewController  else {return}
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        emailResetAlert()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
          guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if let err = err { print(err.localizedDescription) }
            
            if result != nil {
                print("signed in")
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                guard let viewController = storyBoard.instantiateViewController(identifier: "homeScreen") as? HomeViewController  else {return}
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            } else {
                print("No user")
            }
            
        }
      
    }
    
    //MARK: - Methods
    func emailResetAlert() {
        let controller = UIAlertController(title: "Reset Password", message: "Please enter your email", preferredStyle: .alert)
        controller.addTextField { (textfield) in
            textfield.placeholder = "Enter email..."
        }
        let send = UIAlertAction(title: "Send", style: .default) { (_) in
            guard let email = controller.textFields?.first?.text else {return}
            UserController.sharedUserController.updatePassword(email: email)
        }
        controller.addAction(send)
        present(controller, animated: true)
    }
    
    func textFieldSetup() {
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if emailTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
            KeyboardAvoid.keyboardNotifications(view: self.view)
        } else if passwordTextField.isFirstResponder {
            textField.resignFirstResponder()
        }
        return true
    }
}
