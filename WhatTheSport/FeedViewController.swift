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

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
        self.addPostBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(queueCreatePost(_:)))
        self.addPostBarButton.tintColor = UIColor.white
        self.navigationItem.setRightBarButtonItems([addPostBarButton], animated: true)
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
    func queueCreatePost(_ _: UIBarButtonItem) {
        if self.createPostVC == nil {
            self.createPostVC = CreatePostViewController()
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
                    let teamIndex = post.get("team") as! Int
                    let team: Team? = teamIndex >= 0 ? teamsList[teamIndex] : nil
                    self.posts.append(Post(postIDVal: post.documentID, sportVal: sportsList[post.get("sport") as! Int], teamVal: team, contentVal: post.get("content") as! String, userIDVal: post.get("userID") as! String, usernameVal: post.get("username") as! String, numLikesVal: post.get("numLikes") as! Int, numCommentsVal: post.get("numComments") as! Int))
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
