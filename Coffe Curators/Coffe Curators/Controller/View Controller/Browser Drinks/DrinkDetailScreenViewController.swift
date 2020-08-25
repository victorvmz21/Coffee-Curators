//
//  DrinkDetailScreenViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/19/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class DrinkDetailScreenViewController: UIViewController {
    
    @IBOutlet weak var likeButton: UIButton!
    
    //Landing pad
    var drinkLandingPad: Drink?

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSetup()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func likeButtonTapped(_ sender: Any) {
        if likeButton.currentImage == UIImage(systemName: "heart") {
            likedByUser()
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            dislikedByUser()
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    // MARK: - Methods
    func buttonSetup() {
        guard let drink = drinkLandingPad, let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore().collection(drinkConstants.collectionNamekey).document(drink.title).collection("likes").document(uid)
        
        db.getDocument { (document, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            
            if let document = document, document.exists {
                self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    func likedByUser() {
        guard let drink = drinkLandingPad, let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore().collection(drinkConstants.collectionNamekey).document(drink.title).collection("likes").document(uid)
        
        db.getDocument { (document, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            
            if let document = document, document.exists {
                print("Already liked")
            } else {
                print("liked")
                db.setData([
                    "uid": uid
                ])
            }
        }
    }
    
    func dislikedByUser() {
        guard let drink = drinkLandingPad, let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore().collection(drinkConstants.collectionNamekey).document(drink.title).collection("likes").document(uid)
        
        db.getDocument { (document, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            
            if let document = document, document.exists {
                print("Disliked")
                db.delete()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
