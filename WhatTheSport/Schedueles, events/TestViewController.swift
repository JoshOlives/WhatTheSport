//
//  TestViewController.swift
//  WhatTheSport
//
//  Created by David Olivares on 8/6/21.
//

import UIKit

class TestViewController: UIViewController {
    
    lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.30
    
    var isSlide = false
    
    lazy var moreButton = UIBarButtonItem(image: UIImage(systemName: "sidebar.leading")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(menuBarButtonTapped))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.navigationItem.setLeftBarButton(moreButton, animated: false)
        
        print(slideInMenuPadding)
        print(self.view.frame.width)
        menuView.pinMenuTo(self.view, with: slideInMenuPadding)
        containerView.edgeTo(self.view)
        //containerView.addSubview(TabBarViewController)
    }
    
    @objc
    func menuBarButtonTapped() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut){
            self.containerView.frame.origin.x = self.isSlide ? 0 : self.containerView.frame.width - self.slideInMenuPadding
        } completion: { (didFinish) in
            self.isSlide.toggle()
            print(self.isSlide)
            print("animation finished")
        }
    }

}
