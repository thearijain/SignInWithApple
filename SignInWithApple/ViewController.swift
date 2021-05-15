//
//  ViewController.swift
//  SignInWithApple
//
//  Created by Ari Jain on 5/15/21.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .cyan
        
        self.view.addSubview(appleLogInButton)
        setupbuttonConstraints()
        
    }
    
    var appleLogInButton : ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(handleLogInWithAppleID), for: .touchUpInside)
        return button
    }()

    func setupbuttonConstraints() {
        appleLogInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appleLogInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            appleLogInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    @objc func handleLogInWithAppleID() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
}

extension UIViewController: ASAuthorizationControllerDelegate {
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = credential.user
            let identityToken = credential.identityToken
            let authCode = credential.authorizationCode
            let realUserStatus = credential.realUserStatus
            let name = credential.fullName
            let email = credential.email
            print("userIdentifier ", userIdentifier)
            print("identityToken ", identityToken)
            print("authCode ", authCode)
            print("realUserStatus ", realUserStatus)
            print("name ", name)
            print("email ", email)
        }
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // handle error
        print(error.localizedDescription)
    }

}


//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .cyan
////        setupProviderLoginView()
//        view.addSubview(appleLogInButton)
//
//        NSLayoutConstraint.activate([
//            appleLogInButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 500)
//        ])
//        print(self.view.center.x)
//        print(self.view.center.y)
//    }
//
//    var appleLogInButton : ASAuthorizationAppleIDButton = {
//        let button = ASAuthorizationAppleIDButton()
//        button.addTarget(self, action: #selector(handleLogInWithAppleID), for: .touchUpInside)
//        return button
//    }()
//
//    @objc func handleLogInWithAppleID() {
//         let request = ASAuthorizationAppleIDProvider().createRequest()
//         request.requestedScopes = [.fullName, .email]
//
//         let controller = ASAuthorizationController(authorizationRequests: [request])
//
//         controller.delegate = self
//         controller.presentationContextProvider = self
//
//         controller.performRequests()
//     }
//
////    @IBAction func signInTapped(_ sender: Any) {
////        let appleIDProvider = ASAuthorizationAppleIDProvider()
////        let request = appleIDProvider.createRequest()
////        request.requestedScopes = [.fullName, .email]
////        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
////        authorizationController.delegate = self
////        authorizationController.performRequests()
//
////    }
//
////    func setupProviderLoginView() {
////        let button = ASAuthorizationAppleIDButton()
////        button.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
////        self.view.addSubview(button)
////
////        NSLayoutConstraint.activate([
////            button.widthAnchor.constraint(equalToConstant: 100),
////            button.heightAnchor.constraint(equalToConstant: 30),
//////            button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 400),
////            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
////            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
////
////        ])
////
////
////    }
////
////    @objc func handleAuthorizationAppleIDButtonPress() {
////        print("Test")
////    }
//
//}
//
//extension ViewController: ASAuthorizationControllerDelegate {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        switch authorization.credential {
//        case let appleIDCredential as ASAuthorizationAppleIDCredential:
//            let userIdentifier = appleIDCredential.user
//
//            let defaults = UserDefaults.standard
//            defaults.set(userIdentifier, forKey: "userIdentifier1")
//
//            //Save the UserIdentifier somewhere in your server/database
////            let vc = UserViewController()
////            vc.userID = userIdentifier
////            self.present(UINavigationController(rootViewController: vc), animated: true)
//            break
//        default:
//            break
//        }
//    }
//}
//
//extension ViewController: ASAuthorizationControllerPresentationContextProviding {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//           return self.view.window!
//    }
//}
//
//
//
////extension ViewController: { ASAuthorizationControllerDelegate {
//
////    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
////        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
////            let userIdentifier = appleIDCredential.user
////            let fullName = appleIDCredential.fullName
////            let email = appleIDCredential.email
////            print("USER ID:", userIdentifier, "\n FULL NAME: ", fullName, "\n EMAIL: ", email)
////        }
////    }
////
////    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
////        print(error.localizedDescription)
////    }
//
////}
