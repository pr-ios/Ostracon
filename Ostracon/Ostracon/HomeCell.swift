//
//  HomeCell.swift
//  Ostracon
//
//  Created by Abdullah AlRashoudi on 1/6/22.
//

import UIKit

class HomeCell: UITableViewCell {
    var artifactLabel: UILabel = {
        $0.text = "artifact"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(artifactLabel)
        NSLayoutConstraint.activate([
            artifactLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            artifactLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
