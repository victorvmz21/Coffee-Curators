//
//  DrinkController.swift
//  Coffe Curators
//
//  Created by Connor Holland on 8/7/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct drinkConstants {
    
    static let userIDKey           = "userID"
    static let collectionNamekey   = "drinks"
    static let drinkTitleKey       = "title"
    static let drinkPictureKey     = "drinkPicture"
    static let machineTypeKey      = "machineType"
    static let coofeRoastKey       = "coofeRoast"
    static let cupsOfCoofeKey      = "howManyCupsOfCoffe"
    static let dairyKey            = "dairy"
    static let swetenerKey         = "swetener"
    static let toppingKey          = "topping"
    static let instructionsKey     = "instructions"
    static let measurementKey      = "measurements"
}

class DrinkController {
    
    //MARK: - Shared Instance
    static let shared = DrinkController()
    
    //MARK: - Database reference
    let db = Firestore.firestore()
    
    //MARK: - CRUD
    //MARK: CREATE
    func createDrink(userId: String, drinkUID: String = UUID().uuidString, title: String, drinkPicture: String, machineType: String,
                     coofeRoast: String, cupsOfCoofe: Int, dairy: String,
                     swetener: String, toppings: [String], instructions: [String],
                     measurements: String) {
        
        let newDrinkDictionary: [String: Any] = [
            drinkConstants.userIDKey       : userId,
            drinkConstants.drinkTitleKey   : title,
            drinkConstants.drinkPictureKey : drinkPicture,
            drinkConstants.machineTypeKey  : machineType,
            drinkConstants.coofeRoastKey   : coofeRoast,
            drinkConstants.cupsOfCoofeKey  : cupsOfCoofe,
            drinkConstants.dairyKey        : dairy,
            drinkConstants.swetenerKey     : swetener,
            drinkConstants.toppingKey      : toppings,
            drinkConstants.instructionsKey : instructions,
            drinkConstants.measurementKey  : measurements
        ]
        
        //Creating drink in public collection
        db.collection(drinkConstants.collectionNamekey).document(drinkUID).setData(newDrinkDictionary) { (error) in
            if let error = error {
                print("Error writing document: \(error) - \(error.localizedDescription)")
            } else {print("Document successfully written!")}
        }
        
        //Creating drink in user collection
        db.collection("users").document(userId).collection(drinkConstants.collectionNamekey).document(drinkUID).setData(newDrinkDictionary) { error in
            if let error = error {
                print("Error writing document: \(error) - \(error.localizedDescription)")
            } else { print("Document successfully written!")}
        }
    }
    
    //MARK: READ (fetch)
    func fetchDrinks(completion: @escaping (Result<Drink, Error>) -> Void) {
        let fetchedDoc =  db.collection(drinkConstants.collectionNamekey)
        
        fetchedDoc.getDocuments { (query, error) in
            if let error = error {
                print("Error fetching document \(error) - \(error.localizedDescription)")
            }
            guard let documents = query?.documents else { return }
            
            for document in documents {
                
                let result = Result { try document.data(as: Drink.self) }
                switch result {
                case .success(let drinks):
                    if let drink = drinks { completion(.success(drink)) }
                case .failure(let error):
                    print("Error: error fetching drinks \(error) - \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
    }
    
    //MARK: UPDATE
    func updateDrink(uid: String, drinkUID: String, Newtitle: String, drinkPicture: String, machineType: String,
                     coofeRoast: String, cupsOfCoofe: Int, dairy: String, swetener: String, toppings: [String],
                     instructions: [String], measurements: String) {
        
        let updatedDrinkDictionary: [String: Any] = [
            drinkConstants.drinkTitleKey   : Newtitle,
            drinkConstants.drinkPictureKey : drinkPicture,
            drinkConstants.machineTypeKey  : machineType,
            drinkConstants.coofeRoastKey   : coofeRoast,
            drinkConstants.cupsOfCoofeKey  : cupsOfCoofe,
            drinkConstants.dairyKey        : dairy,
            drinkConstants.swetenerKey     : swetener,
            drinkConstants.toppingKey      : toppings,
            drinkConstants.instructionsKey : instructions,
            drinkConstants.measurementKey  : measurements
        ]
        
        //Update Public drinks
        db.collection(drinkConstants.collectionNamekey).document(drinkUID).updateData(updatedDrinkDictionary) { error in
            if let error = error {
                print("Error: Couldn't update drinks in public drinks collection \(error.localizedDescription)")
            } else { print("Public drinks collection updated successfully!") }
        }
        
        //Update User drinks
        db.collection("users").document(uid).collection(drinkConstants.collectionNamekey).document(drinkUID).updateData(updatedDrinkDictionary) { error in
            if let error = error {
                print("Error: Couldn't update user drink  collection \(error.localizedDescription)")
            } else { print("User drink collection updated successfully!")}
        }
    }
    
    //MARK: - DELETE
    func deleteDrink(userID: String, drinkUID: String) {
        
        //Delete from Public Drink collection
        db.collection(drinkConstants.collectionNamekey).document(drinkUID).delete { error in
            if let error = error {
                print("Error: Couldnt delete Public Drink - \(error) - \(error.localizedDescription)")
            } else { print("Drink deleted from public drinks successfully!")}
        }
        
        //Delete from User collection
        db.collection("users").document(userID).collection(drinkConstants.collectionNamekey).document(drinkUID).delete { error in
            if let error = error {
                print("Error: Couldn't delete User Drink - \(error) \(error.localizedDescription)")
            } else { print("Drink deleted from user successfully!")}
        }
    }
}
