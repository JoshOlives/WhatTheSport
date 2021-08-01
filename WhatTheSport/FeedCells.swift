//
//  FeedCells.swift
//  WhatTheSport
//
//  Created by Adam Martin on 7/27/21.
//

import Foundation
import UIKit

class PostCell: UITableViewCell {
    private var cellStackView: UIStackView!
    private var usernameLabel: UILabel!
    private var contentLabel: UILabel!
    private var reactionStack: UIStackView!
    private var reactButton: UIButton!
    private var viewCommentsButton: UIButton!
    private var likeCountLabel: UILabel!
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        var cellConstraints: [NSLayoutConstraint] = []
        
        // Create subviews of cell
        self.cellStackView = UIStackView(frame: .zero)
        self.cellStackView.translatesAutoresizingMaskIntoConstraints = false
        self.cellStackView.axis = .vertical
        self.cellStackView.distribution = .fill
        self.cellStackView.spacing = 10
        
        self.usernameLabel = UILabel(frame: .zero)
        self.usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.usernameLabel.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        
        self.contentLabel = UILabel(frame: .zero)
        self.contentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentLabel.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        self.contentLabel.setContentCompressionResistancePriority(UILayoutPriority(800), for: .vertical)
        
        self.reactionStack = UIStackView(frame: .zero)
        self.reactionStack.translatesAutoresizingMaskIntoConstraints = false
        self.reactionStack.axis = .horizontal
        self.reactionStack.distribution = .fill
        self.reactionStack.backgroundColor = UIColor.green
        self.reactionStack.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        
        self.reactButton = UIButton(frame:.zero)
        self.reactButton.translatesAutoresizingMaskIntoConstraints = false
        self.reactButton.setContentCompressionResistancePriority(UILayoutPriority(999), for: .horizontal)
        self.reactButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        
        self.viewCommentsButton = UIButton(frame:.zero)
        self.viewCommentsButton.translatesAutoresizingMaskIntoConstraints = false
        self.viewCommentsButton.setContentCompressionResistancePriority(UILayoutPriority(999), for: .horizontal)
        
        self.likeCountLabel = UILabel(frame:.zero)
        self.likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.likeCountLabel.setContentCompressionResistancePriority(UILayoutPriority(999), for: .horizontal)
        
        // Add subviews to content view
        self.contentView.addSubview(self.cellStackView)
        self.cellStackView.addArrangedSubview(self.usernameLabel)
        self.cellStackView.addArrangedSubview(self.contentLabel)
        self.cellStackView.addArrangedSubview(self.reactionStack)
        self.reactionStack.addArrangedSubview(self.reactButton)
        self.reactionStack.addArrangedSubview(self.viewCommentsButton)
        self.reactionStack.addArrangedSubview(self.likeCountLabel)
        
        // Add contraints and edit subview attributes for cell stack view
        cellConstraints.append(self.cellStackView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor))
        cellConstraints.append(self.cellStackView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor))
        cellConstraints.append(self.cellStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor))
        
        // Add constraints and edit subview attributes for username label
        self.usernameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        cellConstraints.append(self.usernameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20))
        cellConstraints.append(self.usernameLabel.widthAnchor.constraint(equalToConstant: 100))
        cellConstraints.append(self.usernameLabel.heightAnchor.constraint(equalToConstant: 20))
        
        // Add constraints and edit subview attributes for content label
        self.contentLabel.numberOfLines = 0
        cellConstraints.append(self.contentLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -20))
        cellConstraints.append(self.contentLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -100))
        cellConstraints.append(self.contentLabel.topAnchor.constraint(equalTo: self.usernameLabel.bottomAnchor, constant: 10))
        cellConstraints.append(self.contentLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor))
        
        // Add constraints and edit subview attributes for reaction view
        cellConstraints.append(self.reactionStack.widthAnchor.constraint(equalTo: contentLabel.widthAnchor))
        cellConstraints.append(self.reactionStack.heightAnchor.constraint(equalToConstant: 50))
        cellConstraints.append(self.reactionStack.bottomAnchor.constraint(equalTo: self.cellStackView.bottomAnchor, constant: -10))
        cellConstraints.append(self.reactionStack.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor))
        
        NSLayoutConstraint.activate(cellConstraints)    // Activate constraints
    }
    
    func setValues(usernameVal: String, contentVal: String) {
        self.usernameLabel.text = usernameVal
        self.contentLabel.text = contentVal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
