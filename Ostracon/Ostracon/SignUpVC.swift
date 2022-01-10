//
//  SignUpVC.swift
//  Ostracon
//
//  Created by Abdullah AlRashoudi on 1/3/22.
//

import UIKit
import Firebase

class SignUpVC: UIViewController{
    
    let db = Firestore.firestore()
    
    var nameTextField: UITextField = {
        $0.placeholder = "name"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.5963299274, green: 0.5891020894, blue: 0.5924932361, alpha: 1)
        $0.clipsToBounds = true
        $0.layer.cornerRadius =  15
       
        return $0
    }(UITextField())

    
    var emailTextField: UITextField = {
        $0.placeholder = "email"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.5963299274, green: 0.5891020894, blue: 0.5924932361, alpha: 1)
        $0.clipsToBounds = true
        $0.layer.cornerRadius =  15
        $0.autocapitalizationType = .none
        return $0
    }(UITextField())
    
    var passwordTextField: UITextField = {
        $0.placeholder = "password"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderWidth = 1
        $0.borderStyle = .roundedRect
        $0.layer.borderColor = #colorLiteral(red: 0.5963299274, green: 0.5891020894, blue: 0.5924932361, alpha: 1)
        $0.clipsToBounds = true
        $0.layer.cornerRadius =  15
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())
    
    var chooseSegmentedControl: UISegmentedControl = {
        $0.insertSegment(withTitle: "user", at: 0, animated: true)
        $0.insertSegment(withTitle: "museum", at: 1, animated: true)
        $0.backgroundColor = #colorLiteral(red: 0.2627450228, green: 0.2627450228, blue: 0.2627450228, alpha: 1)
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .normal)
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2627450228, green: 0.2627450228, blue: 0.2627450228, alpha: 1)], for: .selected)
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UISegmentedControl())
    
    var signInLabel: UILabel = {
        $0.text = "You've an account?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = #colorLiteral(red: 0.5963299274, green: 0.5891020894, blue: 0.5924932361, alpha: 1)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    var signInButton: UIButton = {
        $0.setTitle("Log in", for: .normal)
        $0.setTitleColor(#colorLiteral(red: 0, green: 0.2731370926, blue: 1, alpha: 1), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.addTarget(self, action: #selector(login), for: .touchUpInside)
        return $0
    }(UIButton())
    
    var signUpButton: UIButton = {
        $0.setTitle("Sign Up", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0, green: 0.2716650367, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)

        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(chooseSegmentedControl)
        view.addSubview(signUpButton)
        view.addSubview(signInLabel)
        view.addSubview(signInButton)
        
        hideKeyboardWhenTappedAround()
        
        NSLayoutConstraint.activate([
            
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            nameTextField.heightAnchor.constraint(equalToConstant: 45),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
                        
            signInLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 45),
            signInLabel.heightAnchor.constraint(equalToConstant: 35),
            signInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -35),
            
            signInButton.leftAnchor.constraint(equalTo: signInLabel.rightAnchor, constant: 5),
            signInButton.topAnchor.constraint(equalTo: signInLabel.topAnchor),
            signInButton.heightAnchor.constraint(equalTo: signInLabel.heightAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 15),
            signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            signUpButton.heightAnchor.constraint(equalToConstant: 45),
            
            chooseSegmentedControl.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 80),
            chooseSegmentedControl.heightAnchor.constraint(equalToConstant: 45),
            chooseSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chooseSegmentedControl.widthAnchor.constraint(equalToConstant: 220)

        ])
        
    }
    
    @objc func signUp() {
        if nameTextField.text?.isEmpty == false {
        if chooseSegmentedControl.selectedSegmentIndex == 0 {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if let error = error {
                    print("error\(error.localizedDescription)")
                    self.emailTextField.invalid()
                    self.passwordTextField.invalid()
                } else {
                    print("The account has been created successfully")
                    self.present(TabBarVC(), animated: true)
                }
                
            }
            db.collection("Users")
                .addDocument(data:
                                [
                                    "email" : emailTextField.text!,
                                    "name" : nameTextField.text!
                                ])
            { error in
                if error == nil {
                    print("User document has been created...")
                } else {
                    print("error\(error!.localizedDescription)")
                }
                
            }
            
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if let error = error {
                    print("error\(error.localizedDescription)")
                    self.emailTextField.invalid()
                    self.passwordTextField.invalid()
                } else {
                    print("The account has been created successfully")
                    self.present(TabBarVC(), animated: true)
                }
            }
            db.collection("Museum")
                .addDocument(data:
                                [
                                    "email" : emailTextField.text!,
                                    "name" : nameTextField.text!
                                ])
            { error in
                if error == nil {
                    print("Museum document has been created...")
                } else {
                    print("error\(error!.localizedDescription)")
                }
            }
            
        }
        } else {
            nameTextField.invalid()
        }
    }
    @objc func login() {
        dismiss(animated: true)
    }
}



    
