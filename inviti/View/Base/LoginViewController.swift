//
//  LoginViewController.swift
//  inviti
//
//  Created by Hannah.C on 03.06.21.
//

import Lottie
import UIKit
import FirebaseAuth
import CryptoKit
import AuthenticationServices

class LoginViewController: UIViewController {
    
    fileprivate var currentNonce: String?
    
    let viewModel = LoginViewModel()
    
    @IBAction func skip(_ sender: Any) {
        
        let testID = "uLkwCQPXM4NrsnFc1mTSmw7GsPu2"
        //        let testID = "5gWVjg7xTHElu9p6Jkl1"
        
        //        let testID = "TPGdezeBE0cgztO0Ui1tzsVwqNd2"
        
        UserDefaults.standard.setValue(testID, forKey: UserDefaults.Keys.uid.rawValue)
        
        self.viewModel.checkIfLogInBefore()
        
        performSegue(withIdentifier: "goToMainSegue", sender: nil)
        
    }
    
    @IBOutlet weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAnimation() 
        
        setUpButton()
        
        viewModel.onGranted = { [weak self] () in
            
            self?.performSegue(withIdentifier: "goToMainSegue", sender: nil)
            
        }
        
        //        self.observeAppleIDSessionChanges()
        
    }
    
    @IBOutlet weak var policyLabel: UILabel!
    
    func setUpButton() {
        
        let button = ASAuthorizationAppleIDButton(type: .continue, style: .black)
        
        
        button.addTarget(self, action: #selector(didTapSignInWithAppleButton), for: UIControl.Event.touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //        button.frame = self.signInWithAppleButton.bounds
        //
        //        self.signInWithAppleButton.addSubview(button)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            //            button.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 160),
            button.topAnchor.constraint(equalTo: policyLabel.topAnchor, constant: -65),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 45),
            button.widthAnchor.constraint(equalToConstant: 280)
        ])
        
    }
    
    func setUpAnimation() {
        
        let animView = AnimationView()
        let anim = Animation.named("56380-calendar", bundle: .main)
        animView.frame = animationView.bounds
        animView.contentMode = .scaleAspectFill
        animView.animation = anim
        animView.loopMode = .loop
        
        animView.play()
        
        animView.play(fromProgress: 0.5, toProgress: 1)
        
        animView.play(fromMarker: "begin", toMarker: "end")
        
        animationView.addSubview(animView)
    }
    
    @objc func didTapSignInWithAppleButton() {
        
        let request: ASAuthorizationAppleIDRequest = ASAuthorizationAppleIDProvider().createRequest()
        
        request.requestedScopes = [.fullName, .email]
        
        let nonce = randomNonceString()
        
        currentNonce = nonce
        
        request.nonce = sha256(nonce)
        
        let controller: ASAuthorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        
        controller.presentationContextProvider = self
        
        controller.performRequests()
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
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap { return String(format: "%02x", $0) }
            
            .joined()
        
        return hashString
    }
    
}

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { authResult, error in
                
                if error != nil {
                    
                    print("Sign In Error: ", error!.localizedDescription)
                    
                    let alertController = UIAlertController(title: "Sign In Error",
                                                            message: error!.localizedDescription,
                                                            preferredStyle: .alert)
                    
                    let okayAction = UIAlertAction(title: "OK",
                                                   style: .cancel,
                                                   handler: nil)
                    
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                guard let user = Auth.auth().currentUser else { return }
                
                
                UserDefaults.standard.setValue(user.uid, forKey: UserDefaults.Keys.uid.rawValue)
                
                UserDefaults.standard.setValue(user.email, forKey: UserDefaults.Keys.email.rawValue)
                
                UserDefaults.standard.setValue(user.displayName, forKey: UserDefaults.Keys.displayName.rawValue)
                
                
                let userManager = UserManager.shared
                
                userManager.user.id = user.uid
                userManager.user.email = user.email ?? ""
                
                self.viewModel.checkIfLogInBefore()
                
            }
        }
    }
    
    // Signin 失敗
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        switch error {
        case ASAuthorizationError.canceled:
            break
        case ASAuthorizationError.failed:
            break
        case ASAuthorizationError.invalidResponse:
            break
        case ASAuthorizationError.notHandled:
            break
        case ASAuthorizationError.unknown:
            break
        default:
            break
        }
        
        print("didCompleteWithError: \(error.localizedDescription)")
    }
    
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
