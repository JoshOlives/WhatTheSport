//
//  ViewController.swift
//  ClassDemo2
//
//  Created by bulko on 6/19/19.
//  Copyright © 2019 bulko. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    var emailField: UITextField!
    var sendResetButton: UIButton!
    var constraint: NSLayoutConstraint!
    @IBOutlet weak var topNav: UINavigationItem!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var constraints: [NSLayoutConstraint] = []
        
        view.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        
        emailField = UITextField(frame: .zero)
        emailField.placeholder = "  Email"
        emailField.backgroundColor = .white
        self.view.addSubview(emailField)
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(emailField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 125))
        constraints.append(emailField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(emailField.widthAnchor.constraint(equalToConstant: view.bounds.width-50))
        constraints.append(emailField.heightAnchor.constraint(equalToConstant: Constants.Field.height))
        
        sendResetButton = UIButton(type: .roundedRect)
        sendResetButton.setTitle("Next", for: .normal)
        sendResetButton.backgroundColor = UIColor(rgb: Constants.Colors.orange)
        sendResetButton.setTitleColor(.white, for: .normal)
        sendResetButton.layer.cornerRadius = 20.0
        self.view.addSubview(sendResetButton)
        
        sendResetButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(sendResetButton.centerXAnchor.constraint(equalTo: emailField.centerXAnchor))
        constraints.append(sendResetButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 125))
        constraints.append(sendResetButton.widthAnchor.constraint(equalTo: emailField.widthAnchor))
        constraints.append(sendResetButton.heightAnchor.constraint(equalTo: emailField.heightAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}

