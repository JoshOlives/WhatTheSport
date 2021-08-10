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
        
        for view in sportViewArray {
            view.addTarget(self, action: #selector(selectSport(_:)), for: .touchDown)
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
            sender.backgroundColor = .white
            let removedSport = selectedSports.remove(at: selectedSports.firstIndex(of: sport)!)
            print(removedSport)
        }
    }    
}

