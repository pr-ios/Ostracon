//
//  TextFieldDesign.swift
//  Ostracon
//
//  Created by Abdullah AlRashoudi on 1/4/22.
//

import UIKit

extension UITextField {
    
    func customTextfield (){
        let underLineView = UIView()
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.backgroundColor = #colorLiteral(red: 0.5963299274, green: 0.5891020894, blue: 0.5924932361, alpha: 1)
        addSubview(underLineView)
        NSLayoutConstraint.activate([
            underLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            underLineView.heightAnchor.constraint(equalToConstant: 1 )
        ])
    }
    
    func invalid() {
        self.layer.borderColor = #colorLiteral(red: 0.8440353274, green: 0.07012300938, blue: 0.2101863027, alpha: 1)
        
    }
}

