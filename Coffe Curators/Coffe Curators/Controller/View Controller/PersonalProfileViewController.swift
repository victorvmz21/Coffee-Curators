//
//  PersonalProfileViewController.swift
//  Coffe Curators
//
//  Created by Connor Holland on 8/24/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PersonalProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var personalSettingLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var passButton: UIButton!
    
    //MARK: - Properties
    var usernameIsEnabled = false
    var emailIsEnabled = false

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editUsernameButtonTapped(_ sender: Any) {
        if usernameButton.currentTitle == "Edit" {
            usernameTextField.isEnabled = true
            usernameTextField.borderStyle = .roundedRect
            usernameButton.setTitle("Save", for: .normal)
        } else if usernameButton.currentTitle == "Save" {
            usernameTextField.isEnabled = false
            usernameTextField.borderStyle = .none
            usernameButton.setTitle("Edit", for: .normal)
            updateUsername()
        }
    }
    
    @IBAction func editEmailButtonTapped(_ sender: Any) {
        
        if emailButton.currentTitle == "Edit" {
            emailTextField.isEnabled = true
            emailTextField.borderStyle = .roundedRect
            emailButton.setTitle("Save", for: .normal)
        } else if emailButton.currentTitle == "Save" {
            emailTextField.isEnabled = false
            emailTextField.borderStyle = .none
            emailButton.setTitle("Edit", for: .normal)
            updateEmail()
        }
    }
    
    @IBAction func editPasswordButtonTapped(_ sender: Any) {
        guard let email = Auth.auth().currentUser?.email else {return}
        UserController.sharedUserController.updatePassword(email: email)
        let controller = UIAlertController(title: nil, message: "Password reset link has been sent", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true)
    }
    
    // MARK: - Methods
    func updateEmail() {
        guard let email = emailTextField.text, !email.isEmpty, let user = Auth.auth().currentUser else {return}
        
        if user.email != email {
            user.updateEmail(to: email) { (err) in
                if let err = err {
                    print(err.localizedDescription)
                    let controller = UIAlertController(title: nil, message: "\(err.localizedDescription)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    controller.addAction(okAction)
                    self.present(controller, animated: true)
                } else {
                    print("updated email")
                    let controller = UIAlertController(title: nil, message: "Updated Email", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    controller.addAction(okAction)
                    self.present(controller, animated: true)
                    Firestore.firestore().collection(StringConstants.userContainer).document(user.uid).updateData([
                        "email" : email
                    ])
                }
            }
        } else {
            print("emails are the same")
        }
    }

    func updateUsername() {
        guard let uid = Auth.auth().currentUser?.uid, let name = usernameTextField.text, !name.isEmpty else {return}
        Firestore.firestore().collection(StringConstants.userContainer).document(uid).updateData([
            "firstName": name,
            "lastName": ""
        ])
    }
    
    func setupView() {
        guard let currentUser = Auth.auth().currentUser else {return}
        
        let query = Firestore.firestore().collection(StringConstants.userContainer).whereField(StringConstants.uidKey, isEqualTo: currentUser.uid)
        query.getDocuments { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                for document in snapshot!.documents {
                    let result = Result {
                        try document.data(as: User.self)
                    }
                    
                    switch result {
                    case .success(let user):
                        if let user = user {
                            self.usernameTextField.text = "\(user.firstName) \(user.lastName)"
                            self.emailTextField.text = user.email
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
            }
        }
        //Username
        usernameTextField.borderStyle = .none
        usernameTextField.font = UIFont(name: "Petrona-ExtraLight", size: 24)
        usernameTextField.textColor = UIColor(named: "black_jolt")
        usernameLabel.font = UIFont(name: "Petrona-Regular", size: 24)
        usernameLabel.textColor = UIColor(named: "black_jolt")
        usernameButton.titleLabel?.font = UIFont(name: "Petrona-ExtraLight", size: 15)
        usernameButton.tintColor = UIColor(named: "black_jolt")
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let UAS = NSAttributedString(string: "Edit", attributes: underlineAttribute)
        usernameButton.titleLabel?.attributedText = UAS
        
        //Email
        emailTextField.borderStyle = .none
        emailTextField.font = UIFont(name: "Petrona-ExtraLight", size: 24)
        emailTextField.textColor = UIColor(named: "black_jolt")
        emailLabel.font = UIFont(name: "Petrona-Regular", size: 24)
        emailLabel.textColor = UIColor(named: "black_jolt")
        emailButton.titleLabel?.font = UIFont(name: "Petrona-ExtraLight", size: 15)
        emailButton.tintColor = UIColor(named: "black_jolt")
        emailButton.titleLabel?.attributedText = UAS
        
        //Password
        passwordLabel.font = UIFont(name: "Petrona-Regular", size: 24)
        passwordLabel.textColor = UIColor(named: "black_jolt")
        passLabel.font = UIFont(name: "Petrona-ExtraLight", size: 24)
        passLabel.textColor = UIColor(named: "black_jolt")
        passButton.titleLabel?.font = UIFont(name: "Petrona-ExtraLight", size: 15)
        passButton.tintColor = UIColor(named: "black_jolt")
        passButton.titleLabel?.attributedText = UAS
        
        //Personal Settings
        personalSettingLabel.font = UIFont(name: "Petrona-SemiBold", size: 24)
        personalSettingLabel.textColor = UIColor(named: "black_jolt")
    }
}
