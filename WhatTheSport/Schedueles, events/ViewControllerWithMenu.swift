import Foundation
import UIKit
import FirebaseStorage
import Firebase
import CoreData

class ViewControllerWithMenu: UIViewController {
    var delegate: TabBarViewController!
    
    lazy var menuView: MenuView = {
        //TODO: add custom menu
        let view = MenuView()
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuView.pinMenuTo(self.view, with: self.slideInMenuPadding)
        self.containerView.edgeTo(self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inTransition = false
        print("APPEARED")
        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
        let menuBackground: UIColor = currentUser!.settings!.dark ? .white : .white
        
        menuView.backgroundColor = menuBackground
        containerView.backgroundColor = background
        
        containerView.frame.origin.x = self.delegate.isSlide ? (containerView.frame.width - self.slideInMenuPadding) : 0
        
        menuView.username.text = fireUser!.get("username") as? String
        menuView.profile.text = fireUser!.get("username") as? String
        guard let urlstring = fireUser!.get("URL") as? String else{
                print("error retreiving urlstring")
                inTransition = false
                return
        }

        IO.downloadImage(str: urlstring, imageView: menuView.userPhoto){}
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerView.frame.origin.x = self.delegate.isSlide ? (containerView.frame.width - self.slideInMenuPadding) : 0
    }
}

public extension UIView {
    func edgeTo(_ view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func pinMenuTo(_ view: UIView, with constant: CGFloat) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -constant).isActive = true
        bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
