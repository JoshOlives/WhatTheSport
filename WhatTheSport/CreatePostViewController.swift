//
//  CreatePostViewController.swift
//  WhatTheSport
//
//  Created by Adam Martin on 7/31/21.
//

import UIKit

class CreatePostViewController: UIViewController {
    private var postTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let safeArea = self.view.bounds.inset(by: view.safeAreaInsets)
        postTextView = UITextView(frame: safeArea)
        postTextView.backgroundColor = UIColor.lightGray
        self.view.addSubview(postTextView)
    }
}
