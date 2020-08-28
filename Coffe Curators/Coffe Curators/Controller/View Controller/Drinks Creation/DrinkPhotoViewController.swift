//
//  DrinkPhotoViewController.swift
//  Coffe Curators
//
//  Created by Victor Monteiro on 8/17/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit

class DrinkPhotoViewController: UIViewController  {
    
    //MARK: - IBOutlet
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var uploadDrinkLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var menuConstraint: NSLayoutConstraint!
    
    //MARK: Properties
    var drinkTitle = ""
    var drinkType  = ""
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
          print(drinkTitle)
    }
    
    //MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: UIButton) {
        menuConstraint.constant = -165
    }
    
    @IBAction func closeOptionButton(_ sender: UIButton) {
        menuConstraint.constant = self.view.frame.size.width
    }
    
    @IBAction func openLIbraryButtonTapped(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true)
        } else {
            let alert = UIAlertController(title: "Photo Library not available", message: "Photo Library is not available in this device", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func openCameraButtonTapped(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.sourceType = .camera
            self.imagePicker.cameraDevice = .rear
            self.imagePicker.cameraCaptureMode = .photo
            self.imagePicker.showsCameraControls = true
            self.present(self.imagePicker, animated: true)
        } else {
            let alert = UIAlertController(title: "Camera not available", message: "camera is not available in this device", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods
    func viewSetup() {
        self.imagePicker.delegate = self
        self.mainTitleLabel.text = "Upload a photo for \(drinkTitle)"
        uploadDrinkLabel.addBrowBorder()
        backButton.addBrowBorder()
         menuConstraint.constant = self.view.frame.size.width
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoToAppliance" {
            guard let destination = segue.destination as? DrinkApplianceViewController else { return }
            guard let data = self.drinkImageView.image?.jpegData(compressionQuality: 0.3) else { return }
            
            destination.drinkType = drinkType
            destination.drinkTitle = drinkTitle
            destination.image = data
        }
    }
}
extension DrinkPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
        info: [UIImagePickerController.InfoKey : Any]) {
        
        var pickerControllerImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            pickerControllerImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            pickerControllerImage = originalImage
        }
        
        if let selectedImage = pickerControllerImage {
            self.drinkImageView.image = selectedImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
