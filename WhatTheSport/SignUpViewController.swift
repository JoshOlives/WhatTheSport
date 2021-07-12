//
//  ViewController.swift
//  ClassDemo2
//
//  Created by bulko on 6/19/19.
//  Copyright © 2019 bulko. All rights reserved.
//

import UIKit
import Firebase

protocol Transitioner {
    func signIn (email: String, password: String)
}

class SignUpViewController: UIViewController, Transitioner {

    var emailField: UITextField!
    var usernameField: UITextField!
    var passwordField: UITextField!
    var confirmField: UITextField!
    var signUpButton: UIButton!
    var signInVC: SignInViewController!
    var constraint: NSLayoutConstraint!
    var logo: UIImageView!
    var signInLabel: UIButton!
    
    let fieldSpacing: CGFloat = 15
    let fieldHeight: CGFloat = 45
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var constraints: [NSLayoutConstraint] = []
        
        view.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        self.title = "Sign Up"
        
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
        signUpButton.addTarget(self, action: #selector(signUpPress), for: .touchUpInside)
        self.view.addSubview(signUpButton)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(signUpButton.centerXAnchor.constraint(equalTo: confirmField.centerXAnchor))
        constraints.append(signUpButton.topAnchor.constraint(equalTo: confirmField.bottomAnchor, constant: fieldSpacing * 1.75))
        constraints.append(signUpButton.widthAnchor.constraint(equalTo: emailField.widthAnchor))
        constraints.append(signUpButton.heightAnchor.constraint(equalTo: emailField.heightAnchor))
        
//        signInLabel = UILabel(frame: .zero)
//        signInLabel.textColor = .blue
//        signInLabel.attributedText = NSAttributedString(string: "SignIn", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
//        signInLabel.textAlignment = .center
//        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.signInPress))
//        signInLabel.isUserInteractionEnabled = true
//        signInLabel.addGestureRecognizer(tap)
//        self.view.addSubview(signInLabel)
        signInLabel = UIButton(type: .roundedRect)
        signInLabel.backgroundColor = UIColor(rgb: Constants.Colors.orange).withAlphaComponent(0)
        signInLabel.setTitleColor(.blue, for: .normal)
        signInLabel.addTarget(self, action: #selector(signInPress), for: .touchUpInside)
        let signInAttributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue, .font: UIFont.systemFont(ofSize: 16)]
        signInLabel.setAttributedTitle(NSMutableAttributedString(string: "Sign In", attributes: signInAttributes), for: .normal)
        self.view.addSubview(signInLabel)
        
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(signInLabel.centerXAnchor.constraint(equalTo: signUpButton.centerXAnchor))
        constraints.append(signInLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: Constants.Field.spacing))
        constraints.append(signInLabel.widthAnchor.constraint(equalTo: signUpButton.widthAnchor, multiplier: 1/5.0))
        constraints.append(signInLabel.heightAnchor.constraint(equalTo: signUpButton.heightAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func signInPress(sender: UIButton!) {
        if signInVC == nil {
            signInVC = SignInViewController()
        }
        signInVC.signUpVC = self

        if let navigator = navigationController {
            navigator.pushViewController(signInVC, animated: true)
        }
    }

    @objc func signUpPress(sender: UIButton!) {
        guard let email = emailField.text,
              let password = passwordField.text,
              email.count > 0,
              password.count > 0
        else {
          return
        }
        
        if let confirm = confirmField.text,
        confirm == password {
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if error == nil {
                    self.signIn (email: email, password: password)
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
    }
    
    func signIn (email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
          user, error in
          if error == nil {
            //TODO: segue to home page
          } else {
            print(error!.localizedDescription)
          }
        }
    }
    
}

