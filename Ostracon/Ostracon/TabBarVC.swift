//
//  TabBarVC.swift
//  Ostracon
//
//  Created by Abdullah AlRashoudi on 1/4/22.
//

import UIKit
import Firebase

class TabBarVC: UITabBarController {
   static var userType = "user"
    let db = Firestore.firestore()
    let currentEmail = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = #colorLiteral(red: 0, green: 0.2716650367, blue: 1, alpha: 1)
        self.modalPresentationStyle = .fullScreen
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: ExploringVC())
        let vc3 = UINavigationController(rootViewController: FavoritesVC())
        let vc4 = UINavigationController(rootViewController: SettingsVC())
        let vc5 = UINavigationController(rootViewController: PostVC())
        vc1.title = "Home"
        vc2.title = "Exploring"
        vc3.title = "Favorites"
        vc4.title = "Settings"
        vc5.title = "Post"
        if TabBarVC.userType == "user" {
            self.setViewControllers([vc1,vc2,vc3,vc4], animated: true)

            guard let items = self.tabBar.items else {return}
            
            let images = ["house","map","heart","gear.circle"]
            
            for i in 0..<items.count {
                items[i].image = UIImage(systemName: images[i])
            }
        } else {
          
            self.setViewControllers([vc1,vc2,vc5,vc3,vc4], animated: true)

            guard let items = self.tabBar.items else {return}
            
            let images = ["house","map","plus.circle","heart","gear.circle"]
            
            for i in 0..<items.count {
                items[i].image = UIImage(systemName: images[i])
            }
        }
        
    }
   
}

