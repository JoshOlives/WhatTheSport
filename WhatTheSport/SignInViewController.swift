//
//  ViewController.swift
//  ClassDemo2
//
//  Created by bulko on 6/19/19.
//  Copyright © 2019 bulko. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    var emailField: UITextField!
    var passwordField: UITextField!
    var signInButton: UIButton!
    var constraint: NSLayoutConstraint!
    var forgotPassword: UILabel!
    var logo: UIImageView!
    var signUpVC: SignUpViewController!
    var forgotButton: UIButton!
    var forgotVC: ForgotPasswordViewController!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var constraints: [NSLayoutConstraint] = []
        
        view.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        self.title = "Sign In"
        
        logo = UIImageView(frame: .zero)
        logo.image = UIImage(named: "splash")
        self.view.addSubview(logo)
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(logo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor))
        constraints.append(logo.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(logo.widthAnchor.constraint(equalToConstant: view.bounds.width-50))
        constraints.append(logo.heightAnchor.constraint(equalToConstant: 125))
        
        emailField = TextField(placeholder: "Email")
        self.view.addSubview(emailField)
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(emailField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 125))
        constraints.append(emailField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(emailField.widthAnchor.constraint(equalToConstant: view.bounds.width-50))
        constraints.append(emailField.heightAnchor.constraint(equalToConstant: Constants.Field.height))
        
        passwordField = SecureTextField(placeholder: "Password")
        self.view.addSubview(passwordField)
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(passwordField.centerXAnchor.constraint(equalTo: emailField.centerXAnchor))
        constraints.append(passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: Constants.Field.spacing))
        constraints.append(passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor))
        constraints.append(passwordField.heightAnchor.constraint(equalTo: emailField.heightAnchor))
        
//        forgotPassword = UILabel(frame: .zero)
//        forgotPassword.textColor = .blue
//        forgotPassword.attributedText = NSAttributedString(string: "Forgot Password?", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
//        forgotPassword.textAlignment = .center
//        self.view.addSubview(forgotPassword)
//
//        forgotPassword.translatesAutoresizingMaskIntoConstraints = false
//        constraints.append(forgotPassword.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor))
//        constraints.append(forgotPassword.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: Constants.Field.spacing))
//        constraints.append(forgotPassword.widthAnchor.constraint(equalTo: emailField.widthAnchor))
//        constraints.append(forgotPassword.heightAnchor.constraint(equalTo: emailField.heightAnchor))
        
        forgotButton = LinkButton(title: "Forgot Password?")
        forgotButton.addTarget(self, action: #selector(forgotPress), for: .touchUpInside)
        self.view.addSubview(forgotButton)
        
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(forgotButton.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor))
        constraints.append(forgotButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: Constants.Field.spacing * 1.75))
        constraints.append(forgotButton.widthAnchor.constraint(equalTo: passwordField.widthAnchor, multiplier: 0.4))
        constraints.append(forgotButton.heightAnchor.constraint(equalTo: passwordField.heightAnchor))
        
        signInButton = Button(title: "Sign In")
        signInButton.addTarget(self, action: #selector(signInPress), for: .touchUpInside)
        self.view.addSubview(signInButton)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(signInButton.centerXAnchor.constraint(equalTo: forgotButton.centerXAnchor))
        constraints.append(signInButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: Constants.Field.spacing * 1.75))
        constraints.append(signInButton.widthAnchor.constraint(equalTo: passwordField.widthAnchor))
        constraints.append(signInButton.heightAnchor.constraint(equalTo: passwordField.heightAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }

    @objc func signInPress(sender: UIButton!) {
        guard let email = emailField.text,
              let password = passwordField.text,
              email.count > 0,
              password.count > 0
        else {
          return
        }
        let delegate = signUpVC! as Transitioner
        delegate.signIn(email: email, password: password)
    }
    
    @objc func forgotPress(sender: UIButton!) {
        if forgotVC == nil {
            forgotVC = ForgotPasswordViewController()
        }

        if let navigator = navigationController {
            navigator.pushViewController(forgotVC, animated: true)
        }
    }
}

