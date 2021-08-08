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

<<<<<<< HEAD:WhatTheSport/FeedViewController.swift
protocol PostAddition {
    func addCreatedPost(newPost: Post)
}

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PostAddition {
=======
class FeedViewController: ViewControllerWithMenu, UITableViewDataSource, UITableViewDelegate {
>>>>>>> 3c35ef7355ffff38100534f70c8c50011c9a4667:WhatTheSport/feed/FeedViewController.swift
    private let feedDB = Firestore.firestore().collection("posts")
    
    var createPostVC: CreatePostViewController!
    var feedTableView: UITableView!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
<<<<<<< HEAD:WhatTheSport/FeedViewController.swift
        self.addPostBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(queueCreatePost))
        self.addPostBarButton.tintColor = UIColor.white
        self.navigationItem.setRightBarButtonItems([self.addPostBarButton], animated: true)
=======
>>>>>>> 3c35ef7355ffff38100534f70c8c50011c9a4667:WhatTheSport/feed/FeedViewController.swift
        getPosts()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        var constraints: [NSLayoutConstraint] = []
        let safeArea = self.view.safeAreaLayoutGuide
        
        
        self.feedTableView = UITableView(frame: .zero)
        self.feedTableView.translatesAutoresizingMaskIntoConstraints = false
        self.feedTableView.register(PostCell.self, forCellReuseIdentifier: cellIdentifier)
        self.feedTableView.dataSource = self
        self.feedTableView.delegate = self
        containerView.addSubview(self.feedTableView)
        constraints.append(self.feedTableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor))
        constraints.append(self.feedTableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor))
        constraints.append(self.feedTableView.topAnchor.constraint(equalTo: safeArea.topAnchor))
        
<<<<<<< HEAD:WhatTheSport/FeedViewController.swift
        self.feedTableView.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        
=======
>>>>>>> 3c35ef7355ffff38100534f70c8c50011c9a4667:WhatTheSport/feed/FeedViewController.swift
        NSLayoutConstraint.activate(constraints)
        
        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
        feedTableView.backgroundColor = background
        feedTableView.reloadData()
    }
    
<<<<<<< HEAD:WhatTheSport/FeedViewController.swift
    @objc
    func queueCreatePost() {
        if self.createPostVC == nil {
            self.createPostVC = CreatePostViewController()
            self.createPostVC.delegate = self
        }
=======
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
>>>>>>> 3c35ef7355ffff38100534f70c8c50011c9a4667:WhatTheSport/feed/FeedViewController.swift
        
//        feedTableView.backgroundColor = background
//        feedTableView.reloadData()
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
<<<<<<< HEAD:WhatTheSport/FeedViewController.swift
                    self.posts.append(Post(postIDArg: post.documentID, sportIndexArg: post.get("sportIndex") as! Int, teamIndexArg: post.get("teamIndex") as? Int, contentArg: post.get("content") as! String, userIDArg: post.get("userID") as! String, usernameArg: post.get("username") as! String, numLikesArg: post.get("numLikes") as! Int, numCommentsArg: post.get("numComments") as! Int, userLikedPostArg: (post.get("likeUserIDs") as! [String]).contains(TestUser.userID)))
=======
                    let teamIndex = post.get("teamIndex") as! Int
                    let team: Team? = teamIndex >= 0 ? teamsList[teamIndex] : nil
                    self.posts.append(Post(postIDVal: post.documentID, sportVal: sportsList[post.get("sportIndex") as! Int], teamVal: team, contentVal: post.get("content") as! String, userIDVal: post.get("userID") as! String, usernameVal: post.get("username") as! String, numLikesVal: post.get("numLikes") as! Int, numCommentsVal: post.get("numComments") as! Int))
>>>>>>> 3c35ef7355ffff38100534f70c8c50011c9a4667:WhatTheSport/feed/FeedViewController.swift
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
