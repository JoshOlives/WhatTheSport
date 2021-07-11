//
//  ViewController.swift
//  ClassDemo2
//
//  Created by bulko on 6/19/19.
//  Copyright © 2019 bulko. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    var emailField: UITextField!
    var usernameField: UITextField!
    var passwordField: UITextField!
    var confirmField: UITextField!
    var signUpButton: UIButton!
    var signInVC: SignInViewController!
    var constraint: NSLayoutConstraint!
    @IBOutlet weak var topNav: UINavigationItem!
    var logo: UIImageView!
    
    let fieldSpacing: CGFloat = 15
    let fieldHeight: CGFloat = 45
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var constraints: [NSLayoutConstraint] = []
        
        view.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        topNav.title = "Sign Up"
        
        logo = UIImageView(frame: .zero)
        logo.image = UIImage(named: "splash")
        self.view.addSubview(logo)
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(logo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor))
        constraints.append(logo.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(logo.widthAnchor.constraint(equalToConstant: view.bounds.width-50))
        constraints.append(logo.heightAnchor.constraint(equalToConstant: 125))
        
        emailField = UITextField(frame: .zero)
        emailField.placeholder = "  Email"
        emailField.backgroundColor = .white
        self.view.addSubview(emailField)
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(emailField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 125))
        constraints.append(emailField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(emailField.widthAnchor.constraint(equalToConstant: view.bounds.width-50))
        constraints.append(emailField.heightAnchor.constraint(equalToConstant: fieldHeight))
        
        usernameField = UITextField(frame: .zero)
        usernameField.placeholder = "  Choose username"
        usernameField.backgroundColor = .white
        self.view.addSubview(usernameField)
    
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(usernameField.centerXAnchor.constraint(equalTo: emailField.centerXAnchor))
        constraints.append(usernameField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: fieldSpacing))
        constraints.append(usernameField.widthAnchor.constraint(equalTo: emailField.widthAnchor))
        constraints.append(usernameField.heightAnchor.constraint(equalTo: emailField.heightAnchor))
        
        passwordField = UITextField(frame: .zero)
        passwordField.placeholder = "  Choose password"
        passwordField.backgroundColor = .white
        self.view.addSubview(passwordField)
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(passwordField.centerXAnchor.constraint(equalTo: usernameField.centerXAnchor))
        constraints.append(passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: fieldSpacing))
        constraints.append(passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor))
        constraints.append(passwordField.heightAnchor.constraint(equalTo: emailField.heightAnchor))
        
        confirmField = UITextField(frame: .zero)
        confirmField.placeholder = "  Repeat password"
        confirmField.backgroundColor = .white
        self.view.addSubview(confirmField)
        
        confirmField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(confirmField.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor))
        constraints.append(confirmField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: fieldSpacing))
        constraints.append(confirmField.widthAnchor.constraint(equalTo: emailField.widthAnchor))
        constraints.append(confirmField.heightAnchor.constraint(equalTo: emailField.heightAnchor))
        
        signUpButton = UIButton(type: .roundedRect)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = UIColor(rgb: Constants.Colors.orange)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.cornerRadius = 20.0
        self.view.addSubview(signUpButton)
        //signUpButton.addTarget(self, action: #selector(button1Pressed), for: .touchUpInside)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(signUpButton.centerXAnchor.constraint(equalTo: confirmField.centerXAnchor))
        constraints.append(signUpButton.topAnchor.constraint(equalTo: confirmField.bottomAnchor, constant: fieldSpacing * 1.75))
        constraints.append(signUpButton.widthAnchor.constraint(equalTo: emailField.widthAnchor))
        constraints.append(signUpButton.heightAnchor.constraint(equalTo: emailField.heightAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }

    @objc func button1Pressed(sender: UIButton!) {
//        if nextVC == nil {
//            nextVC = SecondViewController()
//        }
//        nextVC.delegate = self
//        nextVC.vc2NewName = textField1.text!
//
//        if let navigator = navigationController {
//            navigator.pushViewController(nextVC, animated: true)
//        }
    }
    
}

