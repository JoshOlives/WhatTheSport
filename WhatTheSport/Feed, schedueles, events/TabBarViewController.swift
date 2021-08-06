//
//  TabBarViewController.swift
//  GameList
//
//  Created by John Wang on 8/4/21.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var vc1: UINavigationController!
    var vc2: UINavigationController!
    var vc3: UINavigationController!
    
    var plusButton: UIBarButtonItem!
    var filterButton: UIBarButtonItem!
    var moreButton: UIBarButtonItem!
    var nextVC: FiltersViewController!
    
    var isSlide = false
    var inAnimation = false
    
    @objc
    func menuBarButtonTapped() {
        if inAnimation {
            return
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut){
            self.inAnimation = true
            let currentViewController = UIApplication.getTopViewController() as! ViewControllerWithMenu
            currentViewController.containerView.frame.origin.x = self.isSlide ? 0 : currentViewController.containerView.frame.width - currentViewController.slideInMenuPadding
            print("in animation")
        } completion: { (didFinish) in
            print("finished")
            self.inAnimation = false
            self.isSlide.toggle()
        }
    }
    
    override func viewWillLayoutSubviews() {
        
        moreButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target:self, action: #selector(menuBarButtonTapped))
        
        self.navigationItem.leftBarButtonItem = moreButton
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.delegate = self
        
        filterButton = UIBarButtonItem(image: UIImage(systemName: "arrowtriangle.down.circle.fill"), style: .plain, target:self, action: #selector(filterTransition))
        
        plusButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(rightHandAction))
        
        let gameController = GameScheduleViewController()
        gameController.delegate = self
        vc1 = UINavigationController(rootViewController: gameController)
        vc1.isNavigationBarHidden = true
        vc1.title = "Games"
        
        let feedController = SecondViewController()
        feedController.delegate = self
        vc2 = UINavigationController(rootViewController: feedController)
        vc2.isNavigationBarHidden = true
        vc2.title = "Feed"
        
        let eventsController = ThirdViewController()
        eventsController.delegate = self
        vc3 = UINavigationController(rootViewController: eventsController)
        vc3.isNavigationBarHidden = true
        vc3.title = "Events"
        
        self.setViewControllers([vc1, vc2, vc3], animated: false)
        
        guard let items = self.tabBar.items else {
            return
        }
        
        let images = ["calendar", "house.fill", "star.fill"]
        
        for index in 0 ..< items.count {
          
            items[index].image = UIImage(systemName: images[index])
            items[index].image?.withTintColor(.white)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inTransition = false
        
        print(currentUser!.settings!.dark)
        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
        let navImage: UIImage? = currentUser!.settings!.dark ? UIImage() : nil

        if let nav = navigationController {
            configureNavigator (navigator: nav)
            setTitle()
        }
        
        self.view.backgroundColor = background
        self.tabBar.backgroundImage = navImage
        self.tabBar.barTintColor = UIColor(rgb: Constants.Colors.orange)
        self.tabBar.tintColor = .white
    }

    func configureNavigator (navigator: UINavigationController) {
        let navImage: UIImage? = currentUser!.settings!.dark ? UIImage() : nil
        navigator.navigationBar.setBackgroundImage(navImage, for: .default)
        navigator.navigationBar.barTintColor = UIColor(rgb: Constants.Colors.orange)

        navigator.navigationBar.tintColor = .white
        navigator.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        navigator.navigationBar.barStyle = .black
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        setTitle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func setTitle () {
        var title: String?
        
        switch selectedViewController {
        case vc1:
            title = "Games"
            self.navigationItem.rightBarButtonItems = [filterButton]
        case vc2:
            title = "Feed"
            self.navigationItem.rightBarButtonItems = [plusButton, filterButton]
        case vc3:
            title = "Events"
            self.navigationItem.rightBarButtonItems = [plusButton, filterButton]
        default:
            title = "Should not happen"
        }
        
        self.title = title
    }
    
    @objc
    func filterTransition() {
        if inTransition {
            return
        } else {
            inTransition = true
        }
        
        if nextVC == nil{
            nextVC = FiltersViewController()
        }
        UI.transition(dest: nextVC, src: self)
    }
    
    @objc
    func rightHandAction() {
        print("yoo")
    }
}