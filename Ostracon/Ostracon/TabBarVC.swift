//
//  TabBarVC.swift
//  Ostracon
//
//  Created by Abdullah AlRashoudi on 1/4/22.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: ExploringVC())
        let vc3 = UINavigationController(rootViewController: FavoritesVC())
        let vc4 = UINavigationController(rootViewController: ProfileVC())
       
        self.setViewControllers([vc1,vc2,vc3,vc4], animated: true)

        guard let items = self.tabBar.items else {return}
        
        let images = ["house","map","heart","person"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = #colorLiteral(red: 0, green: 0.2716650367, blue: 1, alpha: 1)
        self.modalPresentationStyle = .fullScreen
    }
    

}
