//
//  CreateCommentViewController.swift
//  WhatTheSport
//
//  Created by Adam Martin on 8/8/21.
//

import UIKit
import FirebaseFirestore

class CreateCommentViewController: UIViewController {
    private var commentTextView: UITextView!
    private var commentBarButton: UIBarButtonItem!
    var delegate: UIViewController!
    
    override func loadView() {
        super.loadView()
        
        let safeArea = self.view.bounds.inset(by: view.safeAreaInsets)
        self.commentTextView = UITextView(frame:
                                        CGRect(x: 0, y: 0, width: safeArea.width, height: safeArea.height / 2))
        
        self.view.addSubview(commentTextView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Comment"
        self.commentBarButton = UIBarButtonItem(title: "Post Comment", style: .plain, target: self, action: #selector(createComment))
        self.commentBarButton.tintColor = UIColor.white
        self.navigationItem.setRightBarButtonItems([self.commentBarButton], animated: true)

        self.view.backgroundColor = UIColor.systemGray6
        self.commentTextView.backgroundColor = UIColor.systemGray6
        self.commentTextView.font = .systemFont(ofSize: 18)
        self.commentTextView.becomeFirstResponder()
    }
    
    @objc
    func createComment() {
        if !self.commentTextView.hasText {
            let alertController = UI.createAlert(title: "Missing Content",
                                                 msg: "Please enter some text for your comment")
                        present(alertController, animated: true, completion: nil)
        } else {
            let currPost = (delegate as! CommentViewController).post
            let fsComment: [String: Any] = ["content": self.commentTextView.text!,
                                            "postID": currPost!.postID,
                                            "userID": fireUser!.documentID,
                                            "userProfilePicID": fireUser!.get("URL")!,
                                            "username": fireUser!.get("username")!]
            
            let feedDB = Firestore.firestore().collection("comments")
            var ref: DocumentReference? = nil
            ref = feedDB.addDocument(data: fsComment, completion: { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    let newComment = Comment(commentIDArg: ref!.documentID, postIDArg: currPost!.postID, usernameArg: fireUser!.get("username")! as! String, userIDArg: fireUser!.documentID, contentArg: self.commentTextView.text)
                    let otherVC = self.delegate as! CommentAddition
                    otherVC.addCreatedComment(newComment: newComment)
                }
            })
        }
    }
}
