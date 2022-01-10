//
//  SignInVC.swift
//  Ostracon
//
//  Created by Abdullah AlRashoudi on 1/2/22.
//

import UIKit
import AuthenticationServices
import CryptoKit
import FirebaseAuth

class SignInVC: UIViewController {
    
    var logoImage: UIImageView = {
        $0.image = UIImage(named: "OstraconLogo")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
        
    var emailTextField: UITextField = {
        $0.placeholder = "email"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.autocapitalizationType = .none
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.5963299274, green: 0.5891020894, blue: 0.5924932361, alpha: 1)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        return $0
    }(UITextField())
    
    var passwordTextField: UITextField = {
        $0.placeholder = "password"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.5963299274, green: 0.5891020894, blue: 0.5924932361, alpha: 1)
        $0.clipsToBounds = true
        $0.isSecureTextEntry = true
        $0.layer.cornerRadius = 15
        
        return $0
    }(UITextField())
    
    var signIn: UIButton = {
        $0.setTitle("Sign In", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0, green: 0.2716650367, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(signInWithEmail), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return $0
    }(UIButton())
    
    var signInWithAppleButton: ASAuthorizationAppleIDButton = {
        $0.addTarget(self, action: #selector(handleSignInWithAppleTapped), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        return $0
    }(ASAuthorizationAppleIDButton())
    
    var leftLine: UIView = {
        $0.backgroundColor = #colorLiteral(red: 0.5963299274, green: 0.5891020894, blue: 0.5924932361, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UIView())

    var orLabel: UILabel = {
        $0.text = "OR"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.textColor = #colorLiteral(red: 0.5963299274, green: 0.5891020894, blue: 0.5924932361, alpha: 1)
        return $0
    }(UILabel())
    
    var righLine: UIView = {
        $0.backgroundColor = #colorLiteral(red: 0.5963299274, green: 0.5891020894, blue: 0.5924932361, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UIView())
    
    var signUpLabel: UILabel = {
        $0.text = "Don't have an account?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = #colorLiteral(red: 0.5963299274, green: 0.5891020894, blue: 0.5924932361, alpha: 1)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    var signUp: UIButton = {
        $0.setTitle("Register", for: .normal)
        $0.setTitleColor(#colorLiteral(red: 0, green: 0.2731370926, blue: 1, alpha: 1), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.addTarget(self, action: #selector(register), for: .touchUpInside)
        return $0
    }(UIButton())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        view.addSubview(logoImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signIn)
        view.addSubview(signInWithAppleButton)
        view.addSubview(leftLine)
        view.addSubview(orLabel)
        view.addSubview(righLine)
        view.addSubview(signUpLabel)
        view.addSubview(signUp)
       
        hideKeyboardWhenTappedAround()
        
        NSLayoutConstraint.activate([
            logoImage.widthAnchor.constraint(equalToConstant: 150),
            logoImage.heightAnchor.constraint(equalToConstant: 150),
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
            emailTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 100),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
        
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            signIn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 45),
            signIn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            signIn.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            signIn.heightAnchor.constraint(equalToConstant: 45),
            
            signInWithAppleButton.topAnchor.constraint(equalTo: signIn.bottomAnchor, constant: 45),
            signInWithAppleButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            signInWithAppleButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            signInWithAppleButton.heightAnchor.constraint(equalToConstant: 45),
            
            leftLine.topAnchor.constraint(equalTo: signInWithAppleButton.bottomAnchor, constant: 45),
            leftLine.leftAnchor.constraint(equalTo: signInWithAppleButton.leftAnchor),
            leftLine.heightAnchor.constraint(equalToConstant: 1),
            leftLine.widthAnchor.constraint(equalToConstant: 150),
            
            orLabel.topAnchor.constraint(equalTo: signInWithAppleButton.bottomAnchor, constant: 23),
            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orLabel.heightAnchor.constraint(equalToConstant: 45),
            
            righLine.topAnchor.constraint(equalTo: signInWithAppleButton.bottomAnchor, constant: 45),
            righLine.rightAnchor.constraint(equalTo: signInWithAppleButton.rightAnchor),
            righLine.heightAnchor.constraint(equalToConstant: 1),
            righLine.widthAnchor.constraint(equalToConstant: 150),
            
            signUpLabel.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 15),
            signUpLabel.heightAnchor.constraint(equalToConstant: 35),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -35),
            
            signUp.leftAnchor.constraint(equalTo: signUpLabel.rightAnchor, constant: 5),
            signUp.topAnchor.constraint(equalTo: signUpLabel.topAnchor),
            signUp.heightAnchor.constraint(equalTo: signUpLabel.heightAnchor)
            
        ])
    }
    
    @objc func handleSignInWithAppleTapped() {
       performSignIn()
    }

    @objc func register() {
        let vc = SignUpVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func signInWithEmail() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authDataResult, error in
            if let error = error {
                print("error\(error.localizedDescription)")
                self.emailTextField.invalid()
                self.passwordTextField.invalid()
            } else {
                self.present(TabBarVC(), animated: true)
            }
        }
    }
    
    func performSignIn() {
        let request = createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()

    }

    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest{
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        return request
    }
    
   // Unhashed nonce.
    fileprivate var currentNonce: String?
    @available(iOS 13, *)
    func startSignInWithAppleFlow() {
      let nonce = randomNonceString()
      currentNonce = nonce
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]
      request.nonce = sha256(nonce)
        if request.user != nil {
            self.present(TabBarVC(), animated: true)
        }
      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.delegate = self
      authorizationController.presentationContextProvider = self
      authorizationController.performRequests()
    }

    
}

    
   



extension SignInVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: a login callback was received, but no login request was sent")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable tp serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)

            Auth.auth().signIn(with: credential) { authDataResult, error in
                if let user = authDataResult?.user {
                    print("Nice! You're now signed in as \(user.uid), email: \(user.email ?? "unknown")")

                }
            }
        }
    }
}

extension SignInVC: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
private func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
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
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}

