//
//  FiltersViewController.swift
//  The final
//
//  Created by John Wang on 8/2/21.
//

import UIKit

class FiltersViewController: UIViewController{
 
    let filtersDisplay = [ "All Teams"]
    
    var allGames = UILabel()
    
    let allGamesToggle = UISwitch()
    var labels: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filters"
        
        var constraints: [NSLayoutConstraint] = []
        
        labels = [allGames]
        
        // allTeams
        allGames.textAlignment = NSTextAlignment.center
        allGames.translatesAutoresizingMaskIntoConstraints = false
        allGames.text = filtersDisplay[0]
        constraints.append( allGames.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40))
        constraints.append( allGames.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        self.view.addSubview(allGames)
        
        allGamesToggle.translatesAutoresizingMaskIntoConstraints = false
        constraints.append( allGamesToggle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40))
        constraints.append( allGamesToggle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70))
        allGamesToggle.isOn = currentUser!.filters!.allGames
        allGamesToggle.addTarget(self, action: #selector(allGamesSwithch), for: .valueChanged)
        self.view.addSubview(allGamesToggle)
        
        
        NSLayoutConstraint.activate(constraints)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        inTransition = false
        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
        let textColor: UIColor =  currentUser!.settings!.dark ? .white : .black
        let navImage: UIImage? = currentUser!.settings!.dark ? UIImage() : nil
        self.navigationController?.navigationBar.setBackgroundImage(navImage, for: .default)
        view.backgroundColor = background
        for label in labels {
            label.textColor = textColor
        }
    }
    
    @objc func allGamesSwithch( sender: UISwitch) {
        currentUser!.filters!.allGames = !(currentUser!.filters!.allGames)
        IO.saveContext()
    }

}


