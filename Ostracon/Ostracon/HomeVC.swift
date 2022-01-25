//
//  HomeVC.swift
//  Ostracon
//
//  Created by Abdullah AlRashoudi on 1/4/22.
//

import UIKit

class HomeVC: UIViewController {
    var artifactsTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        title = "Home"
        profileBarButton()
        artifactsTableView.delegate = self
        artifactsTableView.dataSource = self
        artifactsTableView.register(HomeCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(artifactsTableView)
        
        NSLayoutConstraint.activate([
            artifactsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            artifactsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -200),
            artifactsTableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        
        ])
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

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
