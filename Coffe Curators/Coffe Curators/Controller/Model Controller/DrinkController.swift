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
import FirebaseFirestore
import FirebaseStorage

struct drinkConstants {
    
    static let userIDKey           = "userID"
    static let collectionNamekey   = "drinks"
    static let drinkTitleKey       = "title"
    static let drinkCategoryKey    = "drinkCategory"
    static let drinkPictureKey     = "drinkPicture"
    static let applianceKey        = "appliance"
    static let coofeRoastKey       = "coofeRoast"
    static let coffeeShotKey       = "coffeeShot"
    static let dairyKey            = "dairy"
    static let sweetenerKey        = "swetener"
    static let sweetenerMeasureKey = "sweetenerMeasure"
    static let toppingKey          = "topping"
    static let toppingMeasureKey   = "toppingMeasure"
    static let instructionsKey     = "instructions"
    static let drinkUid = "uid"
}

class DrinkController {
    
    //MARK: - Shared Instance
    static let shared = DrinkController()
    
    //MARK: - Database reference
    let db = Firestore.firestore()
    
    // MARK: - Arrays
    var drinks: [Drink] = []
    var searchedDrinks: [Drink] = []
    
    //MARK: - CRUD
    //MARK: CREATE
    func createDrink(userId: String, drinkUID: String = UUID().uuidString, title: String, drinkCategory: String, drinkPicture: Data, appliance: String, coofeRoast: String, coffeeShot: Int, dairy: String, sweetener: String, sweetenerMeasure: String, topping: [String], toppingMeasure: [String], instructions: [String]) {
        
        let newDrinkDictionary: [String: Any] = [
            drinkConstants.userIDKey         : userId,
            drinkConstants.drinkTitleKey     : title,
            drinkConstants.drinkCategoryKey  : drinkCategory,
            drinkConstants.drinkPictureKey   : drinkPicture,
            drinkConstants.applianceKey      : appliance,
            drinkConstants.coofeRoastKey     : coofeRoast,
            drinkConstants.coffeeShotKey     : coffeeShot,
            drinkConstants.dairyKey          : dairy,
            drinkConstants.sweetenerKey      : sweetener,
            drinkConstants.toppingKey        : topping,
            drinkConstants.toppingMeasureKey : toppingMeasure,
            drinkConstants.instructionsKey   : instructions,
        ]
        
        //Creating drink in public collection
        db.collection(drinkConstants.collectionNamekey).document(title).setData(newDrinkDictionary) { (error) in
            if let error = error {
                print("Error writing document: \(error) - \(error.localizedDescription)")
            } else {
                //uploading Photo
                self.uploadDrinkImage(image: drinkPicture, drinkID: drinkUID)
                print("Document successfully written!")}
        }
        
        //Creating drink in user collection
        db.collection("users").document(userId).collection(drinkConstants.collectionNamekey).document(drinkUID).setData(newDrinkDictionary) { error in
            if let error = error {
                print("Error writing document: \(error) - \(error.localizedDescription)")
            } else { print("Document successfully written!")}
        }
    }
    
    func uploadDrinkImage(image: Data, drinkID: String) {
        
        
        let imageRef = Storage.storage().reference().child("images").child("drink_\(drinkID)")
        imageRef.putData(image, metadata: nil) {  meta, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            imageRef.downloadURL { url, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                guard let url = url else { return }
                let dataReference = Firestore.firestore().collection("images").document()
                let documentUid = dataReference.documentID
                let urlString = url.absoluteString
                
                let data = [
                    "uid": documentUid,
                    "url": urlString
                ]
                
                dataReference.setData(data) { (error) in
                    if let error = error {
                         print("Fail upload drink image.")
                        print(error.localizedDescription)
                    }
                    print("drink image uploaded sucessfully!")
                }
                
            }
        }
    }
    
    func fetchingDrinkImage(drinkUID: String, completion: @escaping (Result<UIImage,Error>) -> Void) {
        let reference = Storage.storage().reference().child("images/drink_\(drinkUID)")
        
        reference.downloadURL { url, error in
            if let error = error {
                print("Error fetching drink image")
                completion(.failure(error))
            }
            
            guard let url = url else { return }
            if let data = try? Data(contentsOf: url) {
                guard let image = UIImage(data: data) else { return }
                print("image fetched successfully!")
                completion(.success(image))
            }
        }
        
    }
    
    //MARK: READ (fetch)
      func fetchDrinks(completion: @escaping (Result<Drink, Error>) -> Void) {
            let fetchedDoc =  db.collection(drinkConstants.collectionNamekey)
    
        fetchedDoc.getDocuments { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                
                for document in snapshot!.documents {
                
                    let result = Result {
                        try document.data(as: Drink.self)
                    }
                    
                    switch result {
                    case .success(let drink):
                        
                        if let drink = drink {
                            self.drinks.append(drink)
                            print(self.drinks.count)
                        }
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    //Fetch drink with search
    func drinkSearch(searchTerm: String, completion: @escaping (Bool) -> Void) {
        let query = db.collection(drinkConstants.collectionNamekey).whereField(drinkConstants.drinkTitleKey, isEqualTo: searchTerm)
        
        var fetchedDrinks: [Drink] = []
        
        query.getDocuments { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                for document in snapshot!.documents {
                    let result = Result {
                        try document.data(as: Drink.self)
                    }
                    
                    switch result {
                    case .success(let drink):
                        if let drink = drink {
                            fetchedDrinks.append(drink)
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                    
                }
            }
            self.searchedDrinks = []
            self.searchedDrinks = fetchedDrinks
            return completion(!self.drinks.isEmpty)
        }
        
    }
    
    
    
//    func fetchDrinks(completion: @escaping (Result<Drink, Error>) -> Void) {
//        let fetchedDoc =  db.collection(drinkConstants.collectionNamekey)
//
//        fetchedDoc.getDocuments { (query, error) in
//            if let error = error {
//                print("Error fetching document \(error) - \(error.localizedDescription)")
//            }
//            guard let documents = query?.documents else { return }
//
//            for document in documents {
//
//                let result = Result { try document.data(as: Drink.self) }
//                switch result {
//                case .success(let drinks):
//                    if let drink = drinks { completion(.success(drink)) }
//                case .failure(let error):
//                    print("Error: error fetching drinks \(error) - \(error.localizedDescription)")
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
    
    //MARK: UPDATE
    func updateDrink(userId: String, drinkUID: String = UUID().uuidString, title: String, drinkCategory: String, drinkPicture: Data, appliance: String, coofeRoast: String, coffeeShot: Int, dairy: String, sweetener: String, sweetenerMeasure: String, topping: [String], toppingMeasure: [String], instructions: [String]) {
        
        let updatedDrinkDictionary: [String: Any] = [
            drinkConstants.drinkTitleKey     : title,
            drinkConstants.drinkCategoryKey  : drinkCategory,
            drinkConstants.drinkPictureKey   : drinkPicture,
            drinkConstants.applianceKey      : appliance,
            drinkConstants.coofeRoastKey     : coofeRoast,
            drinkConstants.coffeeShotKey     : coffeeShot,
            drinkConstants.dairyKey          : dairy,
            drinkConstants.sweetenerKey      : sweetener,
            drinkConstants.toppingKey        : topping,
            drinkConstants.toppingMeasureKey : toppingMeasure,
            drinkConstants.instructionsKey   : instructions
        ]
        
        //Update Public drinks
        db.collection(drinkConstants.collectionNamekey).document(drinkUID).updateData(updatedDrinkDictionary) { error in
            if let error = error {
                print("Error: Couldn't update drinks in public drinks collection \(error.localizedDescription)")
            } else { print("Public drinks collection updated successfully!") }
        }
        
        //Update User drinks
        db.collection("users").document(userId).collection(drinkConstants.collectionNamekey).document(drinkUID).updateData(updatedDrinkDictionary) { error in
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
