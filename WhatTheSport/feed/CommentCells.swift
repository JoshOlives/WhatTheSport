//
//  CommentCells.swift
//  WhatTheSport
//
//  Created by Adam Martin on 8/8/21.
//

import Foundation
import UIKit
import FirebaseFirestore

class CommentCell: UITableViewCell {
    private var comment: Comment? = nil
    private var userProfilePicView: UIImageView!
    private var usernameLabel: UILabel!
    private var contentLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        var cellConstraints: [NSLayoutConstraint] = []
        
        self.userProfilePicView = UIImageView(frame: .zero)
        self.userProfilePicView.translatesAutoresizingMaskIntoConstraints = false
        
        self.usernameLabel = UILabel(frame: .zero)
        self.usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.usernameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        self.contentLabel = UILabel(frame: .zero)
        self.contentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentLabel.numberOfLines = 0
        self.contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        self.contentView.addSubview(self.userProfilePicView)
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.contentLabel)
        
        cellConstraints.append(self.userProfilePicView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10))
        cellConstraints.append(self.userProfilePicView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10))
        cellConstraints.append(self.userProfilePicView.widthAnchor.constraint(equalToConstant: 50))
        cellConstraints.append(self.userProfilePicView.heightAnchor.constraint(equalToConstant: 50))
        
        cellConstraints.append(self.usernameLabel.leadingAnchor.constraint(equalTo: self.userProfilePicView.trailingAnchor, constant: 20))
        cellConstraints.append(self.usernameLabel.widthAnchor.constraint(equalToConstant: 250))
        cellConstraints.append(self.usernameLabel.heightAnchor.constraint(equalToConstant: 20))
        cellConstraints.append(self.usernameLabel.centerYAnchor.constraint(equalTo: self.userProfilePicView.centerYAnchor))
        
        cellConstraints.append(self.contentLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -100))
        cellConstraints.append(self.contentLabel.topAnchor.constraint(equalTo: self.usernameLabel.bottomAnchor, constant: 20))
        cellConstraints.append(self.contentLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10))
        cellConstraints.append(self.contentLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -8))
        
        
                               
        NSLayoutConstraint.activate(cellConstraints)
    }
    
    func setValues(commentArg: Comment) {
        self.comment = commentArg
        if self.userProfilePicView?.image == nil {
            let userDB = Firestore.firestore().collection("users")
            userDB.document(fireUser!.documentID).getDocument { (document, error) in
                if let document = document, document.exists {
                    let url = document.get("URL") as! String
                    IO.downloadImage(str: url, imageView: self.userProfilePicView, completion: nil)
                } else {
                    print("error retreiving firestore data")
                }
            }
        }
        self.usernameLabel.text = commentArg.username
        self.contentLabel.text = commentArg.content
    }
    
    func setTextColor(textColor: UIColor) {
        self.usernameLabel.textColor = textColor
        self.contentLabel.textColor = textColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
