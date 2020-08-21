//
//  SignInViewController.swift
//  Coffe Curators
//
//  Created by Connor Holland on 8/11/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import CryptoKit
import FirebaseAuth
import AuthenticationServices

protocol ReloadViewDelegate {
    func reloadHomeView()
}

class SignInViewController: UIViewController {
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    @IBOutlet weak var appleSignInButton: UIView!
    
    var refreshDelegate: ReloadViewDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
        setUpSignInAppleButton()
        SignInViewController.checkUser()
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    // MARK: - Helper Methods
    
    //setup userCheck
    static func checkUser() {
        guard let user = Auth.auth().currentUser else {return}
        let firstName = user.displayName?.components(separatedBy: " ")[0] ?? "User: \(user.uid)"
        let lastName = user.displayName?.components(separatedBy: " ")[1] ?? ""
        let email = user.email ?? ""
        let uid = user.uid
        UserController.sharedUserController.checkUser(uid: uid, firstName: firstName, lastName: lastName, email: email)
    }
    
    //this function Creates the button!
    func setUpSignInAppleButton() {
        
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAppleIdRequestTapped), for: .touchUpInside)
        authorizationButton.center = appleSignInButton.center
        
        self.appleSignInButton.addSubview(authorizationButton)
        NSLayoutConstraint.activate([
            authorizationButton.centerXAnchor.constraint(equalTo: self.appleSignInButton.centerXAnchor),
            authorizationButton.centerYAnchor.constraint(equalTo: self.appleSignInButton.centerYAnchor),
            authorizationButton.widthAnchor.constraint(equalToConstant: self.appleSignInButton.frame.width),
            authorizationButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func handleAppleIdRequestTapped() {
           performSignIn()
       }
    
    //this function make all the wofk
       func performSignIn() {
           let request = createAppleIDRequest()
           let authorizationController = ASAuthorizationController(authorizationRequests: [request])
           
           authorizationController.delegate = self
           authorizationController.presentationContextProvider = self
           
           authorizationController.performRequests()
       }
    
    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
          let appleIDProvider = ASAuthorizationAppleIDProvider()
          let request = appleIDProvider.createRequest()
          request.requestedScopes = [.fullName, .email]
          
          let nonce = randomNonceString()
          request.nonce = sha256(nonce)
          currentNonce = nonce
          
          return request
      }

    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    //MARK: - IBOutlet
    @IBAction func signInWithEmailButtonTapped(_ sender: UIButton) {
        
    }
}


extension SignInViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("invalid State: a login callback was received but no login request was sent")
            }
            
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("unable to fetch identity token")
                return
            }
            
            
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("unable to serialize toke string from data \(appleIDToken.debugDescription)")
                return
            }
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { (result, error) in
                if let user = result?.user {
                    DispatchQueue.main.async {
                        self.refreshDelegate.reloadHomeView()
                    }
                    self.navigationController?.dismiss(animated: true, completion: nil)
                    print("you're now signed in as \(user.uid) email: \(user.email), name: \(user.displayName)")
                    let firstName = user.displayName?.components(separatedBy: " ")[0] ?? "\(user.uid)"
                    let lastName = user.displayName?.components(separatedBy: " ")[1] ?? "N/A"
                    let email = user.email ?? ""
                    UserController.sharedUserController.checkUser(uid: user.uid, firstName: firstName, lastName: lastName, email: email)
                }
            }
        }
    }
}


extension SignInViewController: GIDSignInDelegate {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let url = GIDSignIn.sharedInstance()?.handle(url) else {return false}
        return url
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // ...
        if let error = error {
          // ...
          return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        // ...
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Signed In")
                DispatchQueue.main.async {
                    self.refreshDelegate.reloadHomeView()
                }
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //...
    }
}
