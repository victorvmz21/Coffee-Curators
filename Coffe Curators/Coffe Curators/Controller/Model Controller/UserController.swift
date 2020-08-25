//
//  UserController.swift
//  Coffe Curators
//
//  Created by Connor Holland on 8/7/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseFirestore

struct UserController {
    // MARK: - Shared Instance
    static let sharedUserController = UserController()
    
    // MARK: - Database reference
    let db = Firestore.firestore()
    
    // MARK: - Source of Truth
    var currentUser: User?
    
    // MARK: - Crud Methods
    //Create user with new credentials
    func createUser(uid: String, firstName: String, lastName: String, email: String, completion: @escaping (Bool) -> Void) {
        
        let userDictionary: [String: Any] = [
            StringConstants.uidKey: uid,
            StringConstants.firstNameKey: firstName,
            StringConstants.lastNameKey: lastName,
            StringConstants.emailKey: email
        ]
        
        db.collection(StringConstants.userContainer).document(uid).setData(userDictionary)
        db.collection(StringConstants.userContainer).document(uid).setData(userDictionary) { (error) in
            if let error = error {
                print(error.localizedDescription)
                return completion(false)
            } else {
                return completion(true)
            }
        }
    }
    
    //update user
    func updateUserInformation(uid: String, email: String, firstName: String, lastName: String) {
        
        Auth.auth().currentUser?.updateEmail(to: email, completion: { (error) in
            if let error = error {
                print("Error with updating email. -\(error.localizedDescription)")
            }
        })
        
        let userDictionary: [String: Any] = [
            StringConstants.emailKey: email,
            StringConstants.firstNameKey: firstName,
            StringConstants.lastNameKey: lastName
        ]
        
        db.collection(StringConstants.userContainer).document(uid).updateData(userDictionary) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    //update password
    func updatePassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                print("There was an error reseting password. -\(error.localizedDescription)")
            } else {
                print("Password reset link has been sent!")
            }
        }
    }
    
    //delete user
    func deleteUser() {
        let user = Auth.auth().currentUser
        user?.delete(completion: { (error) in
            if let error = error {
                print("Failed to delete user. -\(error.localizedDescription)")
            } else {
                print("Account was deleted.")
            }
        })
    }
    
    // MARK: - Helper Methods
    
    //Check if User exists
    func checkUser(uid: String, firstName: String, lastName: String, email: String, completion: @escaping (Bool) -> Void) {
        let ref = db.collection("users").document(uid)
        ref.getDocument { (document, error) in
            if let document = document, document.exists {
                print("Exists")
                return completion(true)
            } else {
                print("Added new User")
//                UserController.sharedUserController.createUser(uid: uid, firstName: firstName, lastName: lastName, email: email)
                
                 //Test
                if Auth.auth().currentUser?.displayName != nil {
                    guard let displayName = Auth.auth().currentUser?.displayName?.components(separatedBy: " ") else {return completion(false)}
                    
                    UserController.sharedUserController.createUser(uid: uid, firstName: displayName[0], lastName: displayName[1], email: email) { (success) in
                        if success {
                            return completion(true)
                        } else {
                            return completion(false)
                        }
                    }
                } else {
                    UserController.sharedUserController.createUser(uid: uid, firstName: "User: \(uid)", lastName: "", email: email) { (success) in
                        if success {
                            return completion(true)
                        } else {
                            return completion(false)
                        }
                    }
                }
            }
        }
    }
    
    //checks if email exists
    func emailCheck(email: String) {
        let query = db.collection("users").whereField("email", isEqualTo: email)
        
        query.getDocuments { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                UserController.sharedUserController.updatePassword(email: email)
            }
        }
    } // End of email check and update func

    //fetchCurrentUser
    func fetchCurrentUser(uid: String, completion: @escaping (Result<User, Error>) -> Void) {
//        guard let userId = Auth.auth().currentUser?.uid else {return}
        let user = db.collection(StringConstants.userContainer).document(uid)
        user.getDocument { (document, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            let result = Result {
                try document?.data(as: User.self)
            }
            print(result)
            switch result {
            case .success(let currentUser):
                if let user = currentUser {
                    completion(.success(user))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    } // End of fetch function
    
}

struct StringConstants {
    static let userContainer = "users"
    static let uidKey = "uid"
    static let firstNameKey = "firstName"
    static let lastNameKey = "lastName"
    static let emailKey = "email"
    static let passwordKey = "password"
    static let profilePicKey = "profilePic"
    static let favoritesKey = "favorites"
    static let commentsKey = "comments"
}
