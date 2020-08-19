//
//  SignUpViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/11/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passowordTextField: UITextField!
    @IBOutlet weak var reenterPasswordTextField: UITextField!
    
    //MARK: Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(identifier: "homeScreen") as? HomeViewController  else {return}
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {return}
        Auth.auth().fetchSignInMethods(forEmail: email) { (providers, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                if providers == nil {
                    print("Empty")
                    self.createUser()
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    guard let viewController = storyBoard.instantiateViewController(identifier: "homeScreen") as? HomeViewController  else {return}
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true, completion: nil)
                } else {
                    print("Exists")
                    //Alert for email already in use
                    let controller = UIAlertController(title: nil, message: "Email is already in use", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
                        print("HI")
                        self.emailTextField.text = ""
                        self.passowordTextField.text = ""
                        self.reenterPasswordTextField.text = ""
                    }
                    controller.addAction(okAction)
                    self.present(controller, animated: true)
                }
            }
        }
    }
    
    //MARK: - Methods
    func createUser() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passowordTextField.text, !password.isEmpty, let passwordTwo = reenterPasswordTextField.text, !passwordTwo.isEmpty else {return}
        
        if password == passwordTwo && password.count >= 6 && passwordTwo.count >= 6 {
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if let err = err {
                    print(err.localizedDescription)
                    self.emailAlert()
                } else {
                    print("created")
                    guard let uid = Auth.auth().currentUser?.uid else {return}
                    UserController.sharedUserController.createUser(uid: uid, firstName: "User:\(uid)", lastName: "", email: email)
                }
            }
        } else {
            passwordAlert()
        }
    } // end of create user function
    
    func passwordAlert() {
        let alertController = UIAlertController(title: nil, message: "Please make sure passwords are the same and greater than six characters in length.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.passowordTextField.text = ""
            self.reenterPasswordTextField.text = ""
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func emailAlert() {
        let alertController = UIAlertController(title: nil, message: "The email address is already in use by another account.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.emailTextField.text = ""
            self.reenterPasswordTextField.text = ""
            self.passowordTextField.text = ""
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
}
