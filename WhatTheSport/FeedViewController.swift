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

protocol PostAddition {
    func addCreatedPost(newPost: Post)
}

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PostAddition {
    private let feedDB = Firestore.firestore().collection("posts")
    
    var createPostVC: CreatePostViewController!
    var feedSegmentedControl: UISegmentedControl!
    var feedTableView: UITableView!
    var addPostBarButton: UIBarButtonItem!
    var filterBarButton: UIBarButtonItem!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        self.addPostBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(queueCreatePost))
        self.addPostBarButton.tintColor = UIColor.white
        self.navigationItem.setRightBarButtonItems([self.addPostBarButton], animated: true)
        getPosts()
        self.view.backgroundColor = UIColor(rgb: Constants.Colors.orange)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        var constraints: [NSLayoutConstraint] = []
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.feedSegmentedControl = UISegmentedControl(frame: .zero)
        self.feedSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.feedSegmentedControl.setBackgroundImage(imageWithColor(color: UIColor(rgb: Constants.Colors.orange)), for: .normal, barMetrics: .default)
        self.feedSegmentedControl.setBackgroundImage(imageWithColor(color: UIColor(rgb: Constants.Colors.orange)), for: .selected, barMetrics: .default)
        self.feedSegmentedControl.setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        let houseImage = UIImage(systemName: "house")
        houseImage!.withTintColor(UIColor.white)
        let calendarImage = UIImage(systemName: "calendar")
        calendarImage!.withTintColor(UIColor.white)
        let starImage = UIImage(systemName: "star.fill")
        starImage!.withTintColor(UIColor.white)
        self.feedSegmentedControl.insertSegment(with: houseImage, at: 0, animated: true)
        self.feedSegmentedControl.insertSegment(with: calendarImage, at: 1, animated: true)
        self.feedSegmentedControl.insertSegment(with: starImage, at: 2, animated: true)
        self.view.addSubview(self.feedSegmentedControl)
        constraints.append(self.feedSegmentedControl.heightAnchor.constraint(equalToConstant: Constants.RadioControl.height))
        constraints.append(self.feedSegmentedControl.widthAnchor.constraint(equalTo: safeArea.widthAnchor))
        constraints.append(self.feedSegmentedControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor))
        
        self.feedTableView = UITableView(frame: .zero)
        self.feedTableView.translatesAutoresizingMaskIntoConstraints = false
        self.feedTableView.register(PostCell.self, forCellReuseIdentifier: cellIdentifier)
        self.feedTableView.dataSource = self
        self.feedTableView.delegate = self
        self.view.addSubview(self.feedTableView)
        constraints.append(self.feedTableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, constant: -Constants.RadioControl.height))
        constraints.append(self.feedTableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor))
        constraints.append(self.feedTableView.topAnchor.constraint(equalTo: safeArea.topAnchor))
        
        self.feedTableView.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    func queueCreatePost() {
        if self.createPostVC == nil {
            self.createPostVC = CreatePostViewController()
            self.createPostVC.delegate = self
        }
        
        if let navigator = navigationController {
            navigator.pushViewController(self.createPostVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! PostCell
        let row = indexPath.row
        let currPost = posts[row]
        cell.setValues(postArg: currPost)
        cell.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
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
                    self.posts.append(Post(postIDArg: post.documentID, sportIndexArg: post.get("sportIndex") as! Int, teamIndexArg: post.get("teamIndex") as? Int, contentArg: post.get("content") as! String, userIDArg: post.get("userID") as! String, usernameArg: post.get("username") as! String, numLikesArg: post.get("numLikes") as! Int, numCommentsArg: post.get("numComments") as! Int, userLikedPostArg: (post.get("likeUserIDs") as! [String]).contains(TestUser.userID)))
                }
                self.feedTableView.reloadData()
            }
        }
    }
    
    // Protocol function for create post view controller
    func addCreatedPost(newPost: Post) {
        self.posts.append(newPost)
    }
    
    // From https://stackoverflow.com/questions/31651983/how-to-remove-border-from-segmented-control
    // create a 1x1 image with this color
    // Used to set background of segmented controller tabs
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
    
    override func viewWillAppear(_ animated: Bool) {
        if self.feedTableView != nil {
            self.feedTableView.reloadData()
        }
    }
}
