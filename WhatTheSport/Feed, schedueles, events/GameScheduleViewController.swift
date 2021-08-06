//
//  GameScheduleViewController.swift
//  GameList
//
//  Created by John Wang on 8/4/21.
//

import UIKit

class GameScheduleViewController: ViewControllerWithMenu, UITableViewDelegate, UITableViewDataSource {
    
    struct Game {
        var date: String
        var time: String
        var team: String
    }
    
    let game1 = Game(date: "Today Friday May 14   1", time: "7:00 pm", team: "CA vs TX 1")
    let game2 = Game(date: "Today Friday May 14   2", time: "8:00 pm", team: "CA vs NM 2")
    let game3 = Game(date: "Today Friday May 14   3", time: "9:00 pm", team: "NM vs TX 3")
    let game4 = Game(date: "Today Friday May 14   4", time: "10:00 pm", team: "NM vs AZ 4")
    let game5 = Game(date: "Today Friday May 14   5", time: "11:00 pm", team: "CA vs AZ 5")
    let game6 = Game(date: "Today Friday May 14   6", time: "12:00 pm", team: "CA vs FL 6")
    let game7 = Game(date: "Today Friday May 14   7", time: "7:30 pm", team: "FL vs TX 7")
    let game8 = Game(date: "Today Friday May 14   8", time: "7:40 pm", team: "FL vs NM 8")
    let game9 = Game(date: "Today Friday May 14   9", time: "7:50 pm", team: "NV vs TX 9")
    let game10 = Game(date: "Tomorrw Saturday May 15    10", time: "7:00 pm", team: "CA vs NV 10")
    let game11 = Game(date: "Tomorrw Saturday May 15    11", time: "8:00 pm", team: "NY vs TX 11")
    let game12 = Game(date: "Tomorrw Saturday May 15    12", time: "9:00 pm", team: "CA vs NY 12")
    let game13 = Game(date: "Tomorrw Saturday May 15    13", time: "9:30 pm", team: "UT vs TX 13")
    let game14 = Game(date: "Tomorrw Saturday May 15    14", time:"10:30 pm", team: "UT vs CA 14")
    let game15 = Game(date: "Tomorrw Saturday May 15    15", time:"10:30 pm", team: "UT vs FL 15")
    let game16 = Game(date: "Today Friday May 14   16", time: "7:00 pm", team: "CA vs TX 16")
    let game17 = Game(date: "Today Friday May 14   17", time: "8:00 pm", team: "CA vs NM 17")
    let game18 = Game(date: "Today Friday May 14   18", time: "9:00 pm", team: "NM vs TX 18")
    let game19 = Game(date: "Today Friday May 14   19", time: "10:00 pm", team: "NM vs AZ 19")
    let game20 = Game(date: "Today Friday May 14   20", time: "11:00 pm", team: "CA vs AZ 20")
    let game21 = Game(date: "Today Friday May 14   21", time: "12:00 pm", team: "CA vs FL 21")
    let game22 = Game(date: "Today Friday May 14   22", time: "7:30 pm", team: "FL vs TX 22")
    let game23 = Game(date: "Today Friday May 14   23", time: "7:40 pm", team: "FL vs NM 23")
    let game24 = Game(date: "Today Friday May 14   24", time: "7:50 pm", team: "NV vs TX 24")
    let game25 = Game(date: "Tomorrw Saturday May 15   25", time: "7:00 pm", team: "CA vs NV 25")
    let game26 = Game(date: "Tomorrw Saturday May 15   26", time: "8:00 pm", team: "NY vs TX 26")
    let game27 = Game(date: "Tomorrw Saturday May 15   27", time: "9:00 pm", team: "CA vs NY 27")
    let game28 = Game(date: "Tomorrw Saturday May 15   28", time: "9:30 pm", team: "UT vs TX 28")
    let game29 = Game(date: "Tomorrw Saturday May 15   29", time:"10:30 pm", team: "UT vs CA 29 ")
    let game30 = Game(date: "Tomorrw Saturday May 15   30", time:"10:30 pm", team: "UT vs FL 30")
    
    var gameList = [Game]()
    
    var colorList = [UIColor.red,  UIColor.yellow, UIColor.gray, UIColor.purple, UIColor.blue, UIColor.lightGray]
    
    var colorIndex = 0
    var gameIndex = 0
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Games"
        
        gameList.append(game1)
        gameList.append(game2)
        gameList.append(game3)
        gameList.append(game4)
        gameList.append(game5)
        gameList.append(game6)
        gameList.append(game7)
        gameList.append(game8)
        gameList.append(game9)
        gameList.append(game10)
        gameList.append(game11)
        gameList.append(game12)
        gameList.append(game13)
        gameList.append(game14)
        gameList.append(game15)
        gameList.append(game16)
        gameList.append(game17)
        gameList.append(game18)
        gameList.append(game19)
        gameList.append(game28)
        gameList.append(game21)
        gameList.append(game22)
        gameList.append(game23)
        gameList.append(game24)
        gameList.append(game25)
        gameList.append(game26)
        gameList.append(game27)
        gameList.append(game28)
        gameList.append(game29)
        gameList.append(game30)
        
        var constraints: [NSLayoutConstraint] = []

       
        containerView.addSubview(tableView)

        self.tableView.tableFooterView = UIView(frame: .zero)
        
       tableView.register(GameTableViewCell.self, forCellReuseIdentifier: GameTableViewCell.identifier)
        tableView.register(GameDateTableViewCell.self, forCellReuseIdentifier: GameDateTableViewCell.identifier)
      
        tableView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(tableView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor))
        constraints.append( tableView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor))
        NSLayoutConstraint.activate(constraints)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
        
        tableView.backgroundColor = background
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()

        if indexPath.row % 2 == 0 {
            cellHeight = 25
        }
        else if indexPath.row % 2 != 0 {
            cellHeight = 80
        }
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let background: UIColor = currentUser!.settings!.dark ? .black : colorList[colorIndex]
        let textColor: UIColor =  currentUser!.settings!.dark ? .white : .black
        
        if indexPath.row % 2 == 0 {
            let dateBackground: UIColor = currentUser!.settings!.dark ? UIColor(rgb: 0x060426) : UIColor(rgb: Constants.Colors.orange)
            let cell = tableView.dequeueReusableCell(withIdentifier: GameDateTableViewCell.identifier, for: indexPath) as! GameDateTableViewCell
            cell.contentView.backgroundColor = dateBackground
            cell.textLabel?.text = gameList[indexPath.row / 2].date
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.identifier, for: indexPath) as! GameTableViewCell
        cell.textLabel?.text = gameList[indexPath.row / 2].time
        cell.displayLabel.text = gameList[indexPath.row / 2].team
        cell.textLabel?.textColor = textColor
        cell.displayLabel.textColor = textColor
        
        cell.updateColor(color: background)
        colorIndex += 1
        if colorIndex == colorList.count {
            colorIndex = 0
        }
//        gameIndex += 1
//        if gameIndex == gameList.count {
//            gameIndex = 0
//        }
        return cell
      
    }
}
