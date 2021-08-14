//
//  CreatePostViewController.swift
//  WhatTheSport
//
//  Created by Adam Martin on 7/31/21.
//

import UIKit
import FirebaseFirestore

class CreatePostViewController: UIViewController {

    
    private var sport: String?
    var team: String?
    private var button: UIButton!
    var postTextView = UITextView(frame: .zero)
    private var postBarButton: UIBarButtonItem!
    private var sportSelector: UIPickerView!
    private var teamSelector: UIPickerView!
    var delegate: UIViewController!
    var chooseTeamVC: SelectTeamController!
    
    
    override func viewSafeAreaInsetsDidChange() {
        var constraints: [NSLayoutConstraint] = []
        
//                                        CGRect(x: 0, y: 0, width: safeArea.width, height: safeArea.height / 2))
        self.postTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.button = Button(title: "Choose team")
        button.addTarget(self, action: #selector(selectTeam), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(button.centerXAnchor.constraint(equalTo: self.postTextView.centerXAnchor))
        constraints.append(button.topAnchor.constraint(equalTo: self.postTextView.bottomAnchor))
        constraints.append(button.widthAnchor.constraint(equalToConstant: view.bounds.width-50))
        constraints.append(button.heightAnchor.constraint(equalToConstant: Constants.Field.height))
        
        //self.sportSelector.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(postTextView)
        self.postTextView.addSubview(sportSelector)
        let safe = self.view.safeAreaLayoutGuide
        
        constraints.append(self.postTextView.topAnchor.constraint(equalTo: safe.topAnchor))
        constraints.append(self.postTextView.widthAnchor.constraint(equalTo: safe.widthAnchor))
        constraints.append(self.postTextView.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 2 - 50))
        
       // constraints.append(self.sportSelector.topAnchor.constraint(equalTo: self.postTextView.bottomAnchor))
       // constraints.append(self.sportSelector.widthAnchor.constraint(equalToConstant: self.view.bounds.width / 4))
       // constraints.append(self.sportSelector.heightAnchor.constraint(equalToConstant: 50))
        self.view.addSubview(button)
        
        self.postTextView.font = .systemFont(ofSize: 18)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sportSelector = UIPickerView(frame: CGRect(x: 100, y: 100, width: 1000, height: 1000))
        
        self.title = "Create Post"
        self.postBarButton = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(createPost))
        self.postBarButton.tintColor = UIColor.white
        self.navigationItem.setRightBarButtonItems([self.postBarButton], animated: true)
        
    }
    
    @objc
    func selectTeam() {
        chooseTeamVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "selectTeamID")
        chooseTeamVC.delegate = self
        
        UI.transition(dest: chooseTeamVC, src: self)
    }
    
    func updateTeam(team: String) {
        self.team = team
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor.systemGray6
        let textColor: UIColor = currentUser!.settings!.dark ? .white : .black
        
        self.postTextView.textColor = textColor
        
        self.postTextView.backgroundColor = background
        self.view.backgroundColor = background
        
        self.postTextView.becomeFirstResponder()
    }
    
    @objc
    func createPost() {
        if self.team == nil {
            let alertController = UI.createAlert(title: "Missing Content",
                                                 msg: "Please select a team for your post")
                        present(alertController, animated: true, completion: nil)
            return
        }
        if !self.postTextView.hasText {
            let alertController = UI.createAlert(title: "Missing Content",
                                                 msg: "Please enter some text for your post")
                        present(alertController, animated: true, completion: nil)
        } else {
            let likeUserIDs: [String] = []
            let fsPost: [String: Any] = ["userID": fireUser!.documentID,
                                         "username": fireUser!.get("username")!,
                                         "team": self.team!,
                                         "sport": "NBA",
                                         "numLikes": 0,
                                         "numComments": 0,
                                         "content": self.postTextView.text!,
                                         "likeUserIDs": likeUserIDs,
                                         "created": FieldValue.serverTimestamp()]
            
            let feedDB = Firestore.firestore().collection("posts")
            var ref: DocumentReference? = nil
            ref = feedDB.addDocument(data: fsPost, completion: { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    let newPost = Post(postIDArg: ref!.documentID, sportArg: "NBA", teamArg: self.team!, contentArg: self.postTextView.text, userIDArg: fireUser!.documentID, usernameArg: fireUser!.get("username") as! String, numLikesArg: 0, numCommentsArg: 0, userLikedPostArg: false, likeUserIDsArg: [])
                    let otherVC = self.delegate as! PostAddition
                    otherVC.addCreatedPost(newPost: newPost)
                    _ = self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
}
