//
//  CreatePostViewController.swift
//  WhatTheSport
//
//  Created by Adam Martin on 7/31/21.
//

import UIKit
import FirebaseFirestore

class CreatePostViewController: UIViewController {
    private var postTextView: UITextView!
    private var postBarButton: UIBarButtonItem!
    var delegate: UIViewController!
    
    override func loadView() {
        super.loadView()
        
        let safeArea = self.view.bounds.inset(by: view.safeAreaInsets)
        self.postTextView = UITextView(frame:
                                        CGRect(x: 0, y: 0, width: safeArea.width, height: safeArea.height / 2))
        
        self.view.addSubview(postTextView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Post"
        self.postBarButton = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(createPost))
        self.postBarButton.tintColor = UIColor.white
        self.navigationItem.setRightBarButtonItems([self.postBarButton], animated: true)

        self.view.backgroundColor = UIColor.systemGray6
        self.postTextView.backgroundColor = UIColor.systemGray6
        self.postTextView.font = .systemFont(ofSize: 18)
        self.postTextView.becomeFirstResponder()
    }
    
    @objc
    func createPost() {
        if !self.postTextView.hasText {
            let alertController = UI.createAlert(title: "Missing Content",
                                                 msg: "Please enter some text for your post")
                        present(alertController, animated: true, completion: nil)
        } else {
            let likeUserIDs: [String] = []
            let fsPost: [String: Any] = ["userID": TestUser.userID,
                                         "username": TestUser.username,
                                         "teamIndex": 1,
                                         "sportIndex": 0,
                                         "numLikes": 0,
                                         "numComments": 0,
                                         "content": self.postTextView.text!,
                                         "likeUserIDs": likeUserIDs]
            
            let feedDB = Firestore.firestore().collection("posts")
            var ref: DocumentReference? = nil
            ref = feedDB.addDocument(data: fsPost, completion: { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    let newPost = Post(postIDArg: ref!.documentID, sportIndexArg: 0, teamIndexArg: 1, contentArg: self.postTextView.text, userIDArg: TestUser.userID, usernameArg: TestUser.username, numLikesArg: 0, numCommentsArg: 0, userLikedPostArg: false, likeUserIDsArg: [])
                    let otherVC = self.delegate as! PostAddition
                    otherVC.addCreatedPost(newPost: newPost)
                    _ = self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
}
