//
//  ProfileVC.swift
//  Ostracon
//
//  Created by Abdullah AlRashoudi on 1/4/22.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {
    let db = Firestore.firestore()
    let currentEmail = Auth.auth().currentUser?.email
    let imageFolderReference = Storage.storage().reference().child("profileImage")
    let imagePicker = UIImagePickerController()
    
    var profileImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "person")
        $0.contentMode = .scaleAspectFit
        $0.setRounded()
        return $0
    }(UIImageView())
    
    var nameLable: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    var changeProfileImageButton: UIButton = {
        $0.setTitle("Change Photo", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0, green: 0.2716650367, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 15
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.addTarget(self, action: #selector(changeProfileImage), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        title = "Profile"
        checkCurrentUser()
        signOutBarButton()
        downloadImage()
        
       
        imagePicker.delegate = self
        
        view.addSubview(profileImage)
        view.addSubview(changeProfileImageButton)
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 120),
            profileImage.widthAnchor.constraint(equalToConstant: 120),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeProfileImageButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 45),
            changeProfileImageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            changeProfileImageButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            changeProfileImageButton.heightAnchor.constraint(equalToConstant: 45)
        ])
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
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    func downloadImage(){
        
        let imageRefrence = imageFolderReference.child("\(currentEmail!)")
        
        imageRefrence.getData(maxSize: 1 * 1024 * 1024) { data, error in
          
            if error != nil {

          } else {
            
            let image = UIImage(data: data!)
            self.profileImage.contentMode = .scaleAspectFill
            self.profileImage.image = image
              
          }
        }
 
    }
    
    @objc func changeProfileImage() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}


extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            if let imageData = selectedImage.jpegData(compressionQuality: 0.1) {
                
                imageFolderReference.child("\(currentEmail!)").putData(imageData, metadata: nil){
                    (metaData , err) in
                    if let error = err {
                        print(error.localizedDescription)
                    }else {
                        print("The Image Has Been Changed")
                    }
                }
            }
     
             profileImage.contentMode = .scaleAspectFit
            profileImage.image = selectedImage
         }

         dismiss(animated: true, completion: nil)
    }
}

extension UIImageView {
    
    func setRounded() {
        
        self.layer.cornerRadius = 60
        self.layer.masksToBounds = true
    }
}
