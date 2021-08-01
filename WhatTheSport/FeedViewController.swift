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
    
    var feedStackView: UIStackView!
    var feedSegmentedControl: UISegmentedControl!
    var feedTableView: UITableView!
    var addPostBarButton: UIBarButtonItem!
    var filterBarButton: UIBarButtonItem!
    var posts: [String] = []
    
    override func loadView() {
        super.loadView()
        var constraints: [NSLayoutConstraint] = []
        let safeArea = self.view.bounds.inset(by: view.safeAreaInsets)
        print(safeArea.height)
        print(safeArea.width)
        self.feedStackView = UIStackView(frame: .zero)
        self.feedStackView.translatesAutoresizingMaskIntoConstraints = false
        self.feedStackView.distribution = .fillEqually
        self.feedStackView.axis = .vertical
        self.view.addSubview(feedStackView)
        constraints.append(self.feedStackView.heightAnchor.constraint(equalToConstant: safeArea.height))
        constraints.append(self.feedStackView.widthAnchor.constraint(equalToConstant: safeArea.width))
        
//        self.feedSegmentedControl = UISegmentedControl(frame: .zero)
//        self.feedSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        self.feedSegmentedControl.backgroundColor = UIColor(rgb: Constants.Colors.orange)
//        self.feedSegmentedControl.insertSegment(withTitle: "Test1", at: 0, animated: true)
//        self.feedSegmentedControl.insertSegment(withTitle: "Test2", at: 1, animated: true)
//        self.feedSegmentedControl.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
//        self.feedSegmentedControl.setContentHuggingPriority(UILayoutPriority(999), for: .vertical)
//        constraints.append(self.feedSegmentedControl.heightAnchor.constraint(equalToConstant: Constants.RadioControl.height))
//        constraints.append(self.feedSegmentedControl.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor))
        
        self.feedTableView = UITableView(frame: feedStackView.bounds)
        self.feedTableView.translatesAutoresizingMaskIntoConstraints = false
        self.feedTableView.register(PostCell.self, forCellReuseIdentifier: cellIdentifier)
        self.feedTableView.dataSource = self
        self.feedTableView.delegate = self
        self.feedTableView.setContentCompressionResistancePriority(UILayoutPriority(50), for: .vertical)
        self.feedTableView.setContentHuggingPriority(UILayoutPriority(50), for: .vertical)
        constraints.append(self.feedTableView.heightAnchor.constraint(equalTo: self.feedStackView.heightAnchor))
        constraints.append(self.feedTableView.widthAnchor.constraint(equalTo: self.feedStackView.widthAnchor))
        
        self.feedStackView.addArrangedSubview(self.feedTableView)
//        self.feedStackView.addArrangedSubview(self.feedSegmentedControl)
        
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        self.addPostBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(queueCreatePost(_:)))
        self.addPostBarButton.tintColor = UIColor.white
        self.navigationItem.setRightBarButtonItems([addPostBarButton], animated: true)
        getPosts()
        self.feedTableView.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        self.view.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
    }
    
    @objc
    func queueCreatePost(_ _: UIBarButtonItem) {
        present(CreatePostViewController(), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! PostCell
        let row = indexPath.row
        let currPost = posts[row]
        cell.setValues(usernameVal: currPost, contentVal: testContent)
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
                    self.posts.append(post.documentID)
                }
                self.feedTableView.reloadData()
            }
        }
    }
}
