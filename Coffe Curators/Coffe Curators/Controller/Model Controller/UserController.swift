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

struct UserController {
    // MARK: - Shared Instance
    static let sharedUserController = UserController()
    
    // MARK: - Database reference
    let db = Firestore.firestore()
    
    // MARK: - Source of Truth
    var currentUser: User?
    
    // MARK: - Crud Methods
    //Create user with new credentials
    func createUser(uid: String, firstName: String, lastName: String, email: String) {
        
        let userDictionary: [String: Any] = [
            StringConstants.uidKey: uid,
            StringConstants.firstNameKey: firstName,
            StringConstants.lastNameKey: lastName,
            StringConstants.emailKey: email
        ]
        
        db.collection(StringConstants.userContainer).document(uid).setData(userDictionary)
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
    
    //Drink update Test
    func updateDrink(title: String) {
        db.collection("users").document("50").collection("drinks").document("Toddy").updateData([
            "title": title
        ])
    }
    
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
