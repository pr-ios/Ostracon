//
//  FavoritesVC.swift
//  Ostracon
//
//  Created by Abdullah AlRashoudi on 1/4/22.
//

import UIKit
import Firebase

class FavoritesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        title = "Favorites"
        checkCurrentUser()
       profileBarButton()
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
    
    func profileBarButton() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let largeBoldArrow = UIImage(systemName: "person.crop.circle", withConfiguration: largeConfig)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: largeBoldArrow, style: .plain, target: self, action: #selector(profil))
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0.2716650367, blue: 1, alpha: 1)
    }
    @objc func profil() {
        let vc = ProfileVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}
