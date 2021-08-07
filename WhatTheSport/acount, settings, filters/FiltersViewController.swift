//
//  FiltersViewController.swift
//  The final
//
//  Created by John Wang on 8/2/21.
//

import UIKit

class FiltersViewController: UIViewController{
 
    let filtersDisplay = ["Followed Teams", "Followed Games", "Followed Sports", "All Games", "All Sports"]
    
//    var button: UIButton!
    var followedTeam = UILabel()
    
    var followedGames = UILabel()
    
    var followedSports = UILabel()
    
    var allGames = UILabel()
    
    var allSports = UILabel()
    
    let followedTeamToggle = UISwitch()
    let followedGamesToggle = UISwitch()
    let followedSportsToggle = UISwitch()
    let allGamesToggle = UISwitch()
    let allSportsToggle = UISwitch()
    var labels: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filters"
        
        var constraints: [NSLayoutConstraint] = []
        
        labels = [followedTeam, followedGames, followedSports, allGames, allSports]
        
        // followedTeam
        followedTeam.textAlignment = NSTextAlignment.center
        followedTeam.translatesAutoresizingMaskIntoConstraints = false
        followedTeam.text = filtersDisplay[0]
        constraints.append( followedTeam.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40))
        constraints.append( followedTeam.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        self.view.addSubview(followedTeam)
        
        followedTeamToggle.translatesAutoresizingMaskIntoConstraints = false
        constraints.append( followedTeamToggle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40))
        constraints.append( followedTeamToggle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70))
        followedTeamToggle.isOn = currentUser!.filters!.followedTeams
        followedTeamToggle.addTarget(self, action: #selector(followedTeamsSwithch), for: .valueChanged)
        self.view.addSubview(followedTeamToggle)
        
        
        // followedgames
        followedGames.textAlignment = NSTextAlignment.center
        followedGames.translatesAutoresizingMaskIntoConstraints = false
        followedGames.text = filtersDisplay[1]
        constraints.append( followedGames.topAnchor.constraint(equalTo: followedTeam.bottomAnchor, constant: 60))
        constraints.append( followedGames.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        self.view.addSubview(followedGames)
        
        followedGamesToggle.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(followedGamesToggle.topAnchor.constraint(equalTo: followedGames.topAnchor))
        constraints.append(followedGamesToggle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70))
        followedGamesToggle.isOn = currentUser!.filters!.followedGames
        followedGamesToggle.addTarget(self, action: #selector(followedGamesSwithch), for: .valueChanged)
        self.view.addSubview(followedGamesToggle)
        
        
        //followedSports
        followedSports.textAlignment = NSTextAlignment.center
        followedSports.translatesAutoresizingMaskIntoConstraints = false
        followedSports.text = filtersDisplay[2]
        constraints.append( followedSports.topAnchor.constraint(equalTo: followedGames.bottomAnchor, constant: 60))
        constraints.append( followedSports.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        self.view.addSubview(followedSports)
        
        followedSportsToggle.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(followedSportsToggle.topAnchor.constraint(equalTo: followedSports.topAnchor))
        constraints.append(followedSportsToggle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70))
        followedSportsToggle.isOn = currentUser!.filters!.followedSports
        followedSportsToggle.addTarget(self, action: #selector(followedSportsSwithch), for: .valueChanged)
        self.view.addSubview(followedSportsToggle)
        
        
        //allGames
        allGames.textAlignment = NSTextAlignment.center
        allGames.translatesAutoresizingMaskIntoConstraints = false
        allGames.text = filtersDisplay[3]
        constraints.append( allGames.topAnchor.constraint(equalTo: followedSports.bottomAnchor, constant: 60))
        constraints.append( allGames.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        self.view.addSubview(allGames)

        allGamesToggle.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(allGamesToggle.topAnchor.constraint(equalTo: allGames.topAnchor))
        constraints.append(allGamesToggle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70))
        allGamesToggle.isOn = currentUser!.filters!.allGames
        allGamesToggle.addTarget(self, action: #selector(allGamesSwithch), for: .valueChanged)
        self.view.addSubview( allGamesToggle)
        
        
        //allSports
        allSports.textAlignment = NSTextAlignment.center
        allSports.translatesAutoresizingMaskIntoConstraints = false
        allSports.text = filtersDisplay[4]
        constraints.append( allSports.topAnchor.constraint(equalTo: allGames.bottomAnchor, constant: 60))
        constraints.append( allSports.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        self.view.addSubview(allSports)
        
        allSportsToggle.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(allSportsToggle.topAnchor.constraint(equalTo: allSports.topAnchor))
        constraints.append(allSportsToggle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70))
        allSportsToggle.isOn = currentUser!.filters!.allSports
        allSportsToggle.addTarget(self, action: #selector(allSportsSwithch), for: .valueChanged)
        self.view.addSubview(allSportsToggle)
        
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
    
    @objc func followedTeamsSwithch( sender: UISwitch) {
        currentUser!.filters!.followedTeams = !(currentUser!.filters!.followedTeams)
        IO.saveContext()
    }
    
    @objc func followedGamesSwithch( sender: UISwitch) {
        currentUser!.filters!.followedGames = !(currentUser!.filters!.followedGames)
        IO.saveContext()
    }
    
    @objc func followedSportsSwithch( sender: UISwitch) {
        currentUser!.filters!.followedSports = !(currentUser!.filters!.followedSports)
        IO.saveContext()
    }
    
    @objc func allGamesSwithch( sender: UISwitch) {
        currentUser!.filters!.allGames = !(currentUser!.filters!.allGames)
        IO.saveContext()
    }
    
    @objc func allSportsSwithch( sender: UISwitch) {
        currentUser!.filters!.allSports = !(currentUser!.filters!.allSports)
        IO.saveContext()
    }

}


