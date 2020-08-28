//
//  LoginViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/11/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import FirebaseAuth

struct LoginStringConstants {
    static let extraLight = "Petrona-ExtraLight"
    static let color = "black_jolt"
}


class LoginViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    //MARK: Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
       textFieldSetup()
        setupViews()
    }
    
    //MARK: - IBActions
    @IBAction func backButtonTapped(_ sender: Any) {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        guard let viewController = storyBoard.instantiateViewController(identifier: "homeScreen") as? HomeViewController  else {return}
//        viewController.modalPresentationStyle = .fullScreen
//        self.present(viewController, animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
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
    func setupViews() {
        titleLabel.font = UIFont(name: LoginStringConstants.extraLight, size: 24)
        titleLabel.textColor = UIColor(named: LoginStringConstants.color)
        emailLabel.font = UIFont(name: LoginStringConstants.extraLight, size: 24)
        emailLabel.textColor = UIColor(ciColor: .black)
        emailTextField.borderColor = UIColor(named: LoginStringConstants.color)
        passwordLabel.font = UIFont(name: LoginStringConstants.extraLight, size: 24)
        passwordLabel.textColor = UIColor(ciColor: .black)
        passwordTextField.borderColor = UIColor(named: LoginStringConstants.color)
        forgotPasswordButton.tintColor = UIColor(named: LoginStringConstants.color)
        forgotPasswordButton.titleLabel?.font = UIFont(name: "Petrona-Light", size: 13.6)
        submitButton.titleLabel?.font = UIFont(name: "Petrona-Regular", size: 24)
        submitButton.tintColor = UIColor(ciColor: .white)
        submitButton.backgroundColor = UIColor(named: "orange_jolt")
    }
    
    
    
    func emailResetAlert() {
        let controller = UIAlertController(title: "Reset Password", message: "Please enter your email", preferredStyle: .alert)
        controller.addTextField { (textfield) in
            textfield.placeholder = "Enter email..."
        }
        let send = UIAlertAction(title: "Send", style: .default) { (_) in
            guard let email = controller.textFields?.first?.text else {return}
            UserController.sharedUserController.updatePassword(email: email)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(send)
        controller.addAction(cancelAction)
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
