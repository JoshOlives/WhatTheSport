//
//  RegisterSportController.swift
//  WhatTheSport
//
//  Created by Adam Gluch on 7/26/21.
//

import UIKit

class RegisterSportController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var sportViewArray: [UIControl]!
    
    @IBOutlet var labelCollection: [UILabel]!
    private var selectedSports: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        view.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        nextButton.backgroundColor = UIColor(rgb: Constants.Colors.orange)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 20.0
        
        if let navigator = navigationController {
            navigator.navigationBar.tintColor = .white
            navigator.navigationBar.barTintColor = UIColor(rgb: Constants.Colors.orange)
            navigator.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
            navigator.navigationBar.barStyle = .black
            //navigator.navigationBar.backgroundColor = UIColor(rgb: Constants.Colors.orange)
        }
        
        for view in sportViewArray {
            view.addTarget(self, action: #selector(selectSport(_:)), for: .touchDown)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
        let navImage: UIImage? = currentUser!.settings!.dark ? UIImage() : nil
        self.navigationController?.navigationBar.setBackgroundImage(navImage, for: .default)
        view.backgroundColor = background
        inTransition = false
        for view in sportViewArray {
            let background: UIColor = currentUser!.settings!.dark ? .darkGray : .white
            view.backgroundColor = background
        }
        for label in labelCollection {
            let textColor: UIColor = currentUser!.settings!.dark ? .white : .black
            label.textColor = textColor
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegisterTeamIdentifier",
            let destination = segue.destination as? RegisterTeamController {
            destination.delegate = self
            destination.selectedSports = self.selectedSports
        }
    }
    
    @objc func selectSport(_ sender: UIControl) {
        var sport = ""
        for label in labelCollection {
            if sender.contains(label) {
                sport = label.text!
            }
        }
        if sender.backgroundColor !=  UIColor(rgb: Constants.Colors.orange) {
            sender.backgroundColor = UIColor(rgb: Constants.Colors.orange)
            selectedSports.append(sport)
        } else {
            let background: UIColor = currentUser!.settings!.dark ? .darkGray : .white
            sender.backgroundColor = background
            let removedSport = selectedSports.remove(at: selectedSports.firstIndex(of: sport)!)
            print(removedSport)
        }
    }    
}

