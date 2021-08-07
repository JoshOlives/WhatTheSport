//
//  CollectionViewCell.swift
//  WhatTheSport
//
//  Created by Glucci on 8/2/21.
//

import UIKit

class SportCell: UICollectionViewCell {
    
    @IBOutlet weak var franchiseLogo: UIImageView!
    @IBOutlet weak var franchiseName: UILabel!
    
    func configure(image: UIImage?, text: String) {
        franchiseLogo.image = image
        franchiseName.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.franchiseLogo.image = nil
        self.franchiseName.text = nil
    }
}


