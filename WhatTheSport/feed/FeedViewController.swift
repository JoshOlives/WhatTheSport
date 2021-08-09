//
//  FeedViewController.swift
//  WhatTheSport
//
//  Created by Adam Martin on 7/25/21.
//

import UIKit
import FirebaseFirestore


let ops: [Int] = []
let cellIdentifier = "FeedCell"
let testContent = "This is some text content that I am writing so that I can see how it looks in a post on our application. I am still typing so that it will be long. I hope that it turns out ok"

class FeedViewController: ViewControllerWithMenu, UITableViewDataSource, UITableViewDelegate {
    private let feedDB = Firestore.firestore().collection("posts")
    
    var createPostVC: CreatePostViewController!
    var feedTableView: UITableView!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        getPosts()
        self.feedTableView = UITableView(frame: .zero)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        var constraints: [NSLayoutConstraint] = []
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.feedTableView.translatesAutoresizingMaskIntoConstraints = false
        self.feedTableView.register(PostCell.self, forCellReuseIdentifier: cellIdentifier)
        self.feedTableView.dataSource = self
        self.feedTableView.delegate = self
        
        containerView.addSubview(self.feedTableView)
        constraints.append(self.feedTableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor))
        constraints.append(self.feedTableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor))
        constraints.append(self.feedTableView.topAnchor.constraint(equalTo: safeArea.topAnchor))
        
        NSLayoutConstraint.activate(constraints)
        
        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
        feedTableView.backgroundColor = background
        feedTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
        
        feedTableView.backgroundColor = background
        feedTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! PostCell
        let row = indexPath.row
        let currPost = posts[row]
        cell.setValues(postArg: currPost)
        
        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
        let textColor: UIColor =  currentUser!.settings!.dark ? .white : .black
        
        
        cell.backgroundColor = background
        cell.changeTextColor(color: textColor)
        cell.changeContentColor(color: background)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func getPosts() {
        feedDB.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print(err)
            } else {
                for post in querySnapshot!.documents {
                    let teamIndex = post.get("teamIndex") as! Int
                    let team: Team? = teamIndex >= 0 ? teamsList[teamIndex] : nil
                    self.posts.append(Post(postIDVal: post.documentID, sportVal: sportsList[post.get("sportIndex") as! Int], teamVal: team, contentVal: post.get("content") as! String, userIDVal: post.get("userID") as! String, usernameVal: post.get("username") as! String, numLikesVal: post.get("numLikes") as! Int, numCommentsVal: post.get("numComments") as! Int))
                }
                self.feedTableView.reloadData()
            }
        }
    }
    
    // From https://stackoverflow.com/questions/31651983/how-to-remove-border-from-segmented-control
    // create a 1x1 image with this color
        private func imageWithColor(color: UIColor) -> UIImage {
            let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()
            context!.setFillColor(color.cgColor);
            context!.fill(rect);
            let image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return image!
        }
}
