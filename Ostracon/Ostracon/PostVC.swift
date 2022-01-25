//
//  PostVC.swift
//  Ostracon
//
//  Created by Abdullah AlRashoudi on 1/17/22.
//

import UIKit
import Firebase
import RealityKit
class PostVC: UIViewController {
    
    let db = Firestore.firestore()
    let imagePicker = UIImagePickerController()
    let currentEmail = Auth.auth().currentUser?.email
    let imageFolderReference = Storage.storage().reference().child("ThumbnailImage")
    let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.usdz], asCopy: true)
    
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
    
    var typeTextField: UITextField = {
        $0.placeholder = "type"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.5963299274, green: 0.5891020894, blue: 0.5924932361, alpha: 1)
        $0.clipsToBounds = true
        $0.layer.cornerRadius =  15
        return $0
    }(UITextField())
    
    var descriptionTextField: UITextField = {
        $0.placeholder = "description"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.contentVerticalAlignment = .top
        $0.layer.borderColor = #colorLiteral(red: 0.5963299274, green: 0.5891020894, blue: 0.5924932361, alpha: 1)
        $0.clipsToBounds = true
        $0.layer.cornerRadius =  15
        return $0
    }(UITextField())
    
    var addThumbnailButton: UIButton = {
        $0.setTitle("Add Thumbnail", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0, green: 0.2716650367, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 15
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.addTarget(self, action: #selector(addThumbnail), for: .touchUpInside)
        return $0
    }(UIButton())
    
    var addUsdzFileButton: UIButton = {
        $0.setTitle("Add Usdz File", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0, green: 0.2716650367, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 15
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.addTarget(self, action: #selector(addUsdzFile), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        title = "Post"
        imagePicker.delegate = self
        hideKeyboardWhenTappedAround()
        
        view.addSubview(nameTextField)
        view.addSubview(typeTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(addThumbnailButton)
        view.addSubview(addUsdzFileButton)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            nameTextField.heightAnchor.constraint(equalToConstant: 45),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            
            typeTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            typeTextField.heightAnchor.constraint(equalToConstant: 45),
            typeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            typeTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            
            descriptionTextField.topAnchor.constraint(equalTo: typeTextField.bottomAnchor, constant: 15),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 300),
            descriptionTextField.widthAnchor.constraint(equalTo: typeTextField.widthAnchor),
            descriptionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            addThumbnailButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 45),
            addThumbnailButton.heightAnchor.constraint(equalToConstant: 45),
            addThumbnailButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            addThumbnailButton.widthAnchor.constraint(equalToConstant: 160),
            
            addUsdzFileButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 45),
            addUsdzFileButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            addUsdzFileButton.heightAnchor.constraint(equalToConstant: 45),
            addUsdzFileButton.widthAnchor.constraint(equalToConstant: 160)
        ])
        controller.delegate = self
        if #available(iOS 11.0, *) {
            controller.allowsMultipleSelection = false
        }
    }
    
    @objc func addThumbnail() {
        if nameTextField.text?.isEmpty == true {
            nameTextField.invalid()
            nameTextField.placeholderColor = #colorLiteral(red: 0.8440353274, green: 0.07012300938, blue: 0.2101863027, alpha: 1)
        } else if typeTextField.text?.isEmpty == true {
            typeTextField.invalid()
            typeTextField.placeholderColor = #colorLiteral(red: 0.8440353274, green: 0.07012300938, blue: 0.2101863027, alpha: 1)
        } else if descriptionTextField.text?.isEmpty == true {
            descriptionTextField.invalid()
            descriptionTextField.placeholderColor = #colorLiteral(red: 0.8440353274, green: 0.07012300938, blue: 0.2101863027, alpha: 1)
        } else {
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func addUsdzFile() {
        if nameTextField.text?.isEmpty == true {
            nameTextField.invalid()
            nameTextField.placeholderColor = #colorLiteral(red: 0.8440353274, green: 0.07012300938, blue: 0.2101863027, alpha: 1)
        } else if typeTextField.text?.isEmpty == true {
            typeTextField.invalid()
            typeTextField.placeholderColor = #colorLiteral(red: 0.8440353274, green: 0.07012300938, blue: 0.2101863027, alpha: 1)
        } else if descriptionTextField.text?.isEmpty == true {
            descriptionTextField.invalid()
            descriptionTextField.placeholderColor = #colorLiteral(red: 0.8440353274, green: 0.07012300938, blue: 0.2101863027, alpha: 1)
        } else {
            present(controller,animated: true)
        }
    }
}

extension PostVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            if let imageData = selectedImage.jpegData(compressionQuality: 0.1) {
                
                imageFolderReference.child("\(currentEmail!)").putData(imageData, metadata: nil){
                    (metaData , err) in
                    if let error = err {
                        print(error.localizedDescription)
                    }else {
                        print("The Image Has Been Uploaded")
                    }
                }
            }
            
        }
        
        dismiss(animated: true, completion: nil)
    }
}


extension PostVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        //TODO: هذا لأكثر من ملف
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        //TODO: هذا لملف واحد
    }
}

