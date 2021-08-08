//
//  SecondViewController.swift
//  GameList
//
//  Created by John Wang on 8/4/21.
//

import UIKit

class SecondViewController: ViewControllerWithMenu {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("BOOGA")
        self.title = "Feed"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DSADAS")
        //self.containerView.backgroundColor = .blue
    }
}
