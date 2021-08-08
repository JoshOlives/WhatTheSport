//
//  CommentViewController.swift
//  WhatTheSport
//
//  Created by Adam Martin on 8/8/21.
//

import UIKit

let commentCellIdentifier = "CommentCell"

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var comments: [Comment] = [Comment(commentIDArg: "Test", postIDArg: "knicksLogo", usernameArg: "TestUser", userIDArg: "Test", contentArg: "Here is some test data")]
    
    private var commentTableView: UITableView!
    private var createCommentView: UIView!
    private var writeView: UIView!
    private var profilePicView: UIImageView!
    private var writeSomethingLabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! CommentCell
        let row = indexPath.row
        let currComment = comments[row]
        cell.setValues(commentArg: currComment)
        
        cell.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(rgb: Constants.Colors.orange)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        var constraints: [NSLayoutConstraint] = []
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.commentTableView = UITableView(frame: .zero)
        self.commentTableView.translatesAutoresizingMaskIntoConstraints = false
        self.commentTableView.register(CommentCell.self, forCellReuseIdentifier: cellIdentifier)
        self.commentTableView.dataSource = self
        self.commentTableView.delegate = self
        self.commentTableView.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        self.commentTableView.separatorStyle = .none
        
        self.createCommentView = UIView(frame: .zero)
        self.createCommentView.translatesAutoresizingMaskIntoConstraints = false
        self.createCommentView.backgroundColor = UIColor(rgb: Constants.Colors.orange)
        
        self.writeView = UIView(frame: .zero)
        self.writeView.translatesAutoresizingMaskIntoConstraints = false
        self.writeView.backgroundColor = UIColor.systemGray5
        
        self.profilePicView = UIImageView(frame: .zero)
        self.profilePicView.translatesAutoresizingMaskIntoConstraints = false
        self.profilePicView.image = UIImage(named: "knicksLogo")
        
        self.writeSomethingLabel = UILabel(frame: .zero)
        self.writeSomethingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.writeSomethingLabel.lineBreakMode = .byWordWrapping
        self.writeSomethingLabel.text = "Write a comment"
        
        self.view.addSubview(self.commentTableView)
        self.view.addSubview(self.createCommentView)
        self.createCommentView.addSubview(self.writeView)
        self.createCommentView.addSubview(self.profilePicView)
        self.writeView.addSubview(self.writeSomethingLabel)
        
        constraints.append(self.commentTableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, constant: -75))
        constraints.append(self.commentTableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor))
        constraints.append(self.commentTableView.topAnchor.constraint(equalTo: safeArea.topAnchor))

        constraints.append(self.createCommentView.heightAnchor.constraint(equalToConstant: 75))
        constraints.append(self.createCommentView.widthAnchor.constraint(equalTo: self.view.widthAnchor))
        constraints.append(self.createCommentView.topAnchor.constraint(equalTo: self.commentTableView.bottomAnchor))
        
        constraints.append(self.profilePicView.leadingAnchor.constraint(equalTo: self.createCommentView.leadingAnchor, constant: 10))
        constraints.append(self.profilePicView.topAnchor.constraint(equalTo: self.createCommentView.topAnchor, constant: 20))
        constraints.append(self.profilePicView.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(self.profilePicView.widthAnchor.constraint(equalToConstant: 50))
        
        constraints.append(self.writeView.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(self.writeView.widthAnchor.constraint(lessThanOrEqualToConstant: 250))
        constraints.append(self.writeView.centerYAnchor.constraint(equalTo: self.profilePicView.centerYAnchor))
        constraints.append(self.writeView.leadingAnchor.constraint(equalTo: self.profilePicView.trailingAnchor, constant: 10))
        
        constraints.append(self.writeSomethingLabel.heightAnchor.constraint(equalToConstant: 20))
        constraints.append(self.writeSomethingLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250))
        constraints.append(self.writeSomethingLabel.centerYAnchor.constraint(equalTo: self.writeView.centerYAnchor))
        
        NSLayoutConstraint.activate(constraints)
        
//        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
//        commentTableView.backgroundColor = background
        commentTableView.reloadData()
    }
}
