//
//  ProfileVC.swift
//  Ostracon
//
//  Created by Abdullah AlRashoudi on 1/4/22.
//

import UIKit
import Firebase
class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        checkCurrentUser()
        signOutBarButton()
        
    }
    
    func checkCurrentUser() {
        if let user = Auth.auth().currentUser {
            print("You're signed in as \(user.uid), email: \(user.email ?? "unknown")")
        } else {
            let vc = SignInVC()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    func signOutBarButton() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let largeBoldArrow = UIImage(systemName: "rectangle.portrait.and.arrow.right", withConfiguration: largeConfig)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: largeBoldArrow, style: .plain, target: self, action: #selector(signOut))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0.2716650367, blue: 1, alpha: 1)
    }
    
    @objc func signOut() {
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Log Out", style: .destructive) { action in
            
            do {
                try Auth.auth().signOut()
                let vc = SignInVC()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
}
