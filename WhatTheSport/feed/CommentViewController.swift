//
//  CommentViewController.swift
//  WhatTheSport
//
//  Created by Adam Martin on 8/8/21.
//

import UIKit
import FirebaseFirestore

let commentCellIdentifier = "CommentCell"

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var comments: [Comment] = []
    
    private var commentTableView: UITableView!
    private var createCommentView: UIView!
    private var writeView: UIView!
    private var profilePicView: UIImageView!
    private var writeSomethingLabel: UILabel!
    private var createCommentVC: CreateCommentViewController? = nil
    
    var post: Post? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! CommentCell
        let row = indexPath.row
        let currComment = self.comments[row]
        cell.setValues(commentArg: currComment)
        
        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
        let textColor: UIColor = currentUser!.settings!.dark ? .white : .black
        cell.backgroundColor = background
        cell.setTextColor(textColor: textColor)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentTableView = UITableView(frame: .zero)
        self.createCommentView = UIView(frame: .zero)
        self.writeView = UIView(frame: .zero)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        var constraints: [NSLayoutConstraint] = []
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.commentTableView.translatesAutoresizingMaskIntoConstraints = false
        self.commentTableView.register(CommentCell.self, forCellReuseIdentifier: cellIdentifier)
        self.commentTableView.dataSource = self
        self.commentTableView.delegate = self
        self.commentTableView.separatorStyle = .none
        
        self.createCommentView.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.writeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(writeViewPressed)))
        self.writeView.translatesAutoresizingMaskIntoConstraints = false
        
        self.profilePicView = UIImageView(frame: .zero)
        self.profilePicView.translatesAutoresizingMaskIntoConstraints = false
        if self.profilePicView?.image == nil {
            let userDB = Firestore.firestore().collection("users")
            userDB.document(fireUser!.documentID).getDocument { (document, error) in
                if let document = document, document.exists {
                    let url = document.get("URL") as! String
                    IO.downloadImage(str: url, imageView: self.profilePicView, completion: nil)
                } else {
                    print("error retreiving firestore data")
                }
            }
        }

        
        self.writeSomethingLabel = UILabel(frame: .zero)
        self.writeSomethingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.writeSomethingLabel.lineBreakMode = .byWordWrapping
        self.writeSomethingLabel.textAlignment = .center
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
        constraints.append(self.writeSomethingLabel.centerXAnchor.constraint(equalTo: self.writeView.centerXAnchor))
        
        NSLayoutConstraint.activate(constraints)
        
        commentTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inTransition = false
        self.comments = []
        if self.commentTableView != nil {
            comments = []
            getComments()
            self.commentTableView.reloadData()
        }
        let createBackground = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.orange)
        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
        let writeBackground = currentUser!.settings!.dark ? UIColor.systemGray : UIColor.systemGray5
        
        self.view.backgroundColor = createBackground
        self.commentTableView.backgroundColor = background
        self.createCommentView.backgroundColor = createBackground
        
        self.writeView.backgroundColor = writeBackground
        
        self.commentTableView.reloadData()
    }
    
    @objc
    func writeViewPressed() {
        if inTransition {
            return
        } else {
            inTransition = true
        }
        if self.createCommentVC == nil {
            self.createCommentVC = CreateCommentViewController()
        }
        self.createCommentVC!.delegate = self
        self.navigationController?.pushViewController(self.createCommentVC!, animated: true)
    }
    
    func getComments() {
        let commentsDB = Firestore.firestore().collection("comments")
        commentsDB.whereField("postID", isEqualTo: post!.postID).getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting comments: \(err)")
            } else {
                for comment in querySnapshot!.documents {
                    self.comments.append(Comment(commentIDArg: comment.documentID, postIDArg: comment.get("postID") as! String, usernameArg: comment.get("username") as! String, userIDArg: comment.get("userID") as! String, contentArg: comment.get("content") as! String))
                }
            }
            self.commentTableView.reloadData()
        }
    }
}
