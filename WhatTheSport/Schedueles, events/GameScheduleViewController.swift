//
//  GameScheduleViewController.swift
//  GameList
//
//  Created by John Wang on 8/4/21.
//

import UIKit
import Firebase

class GameScheduleViewController: ViewControllerWithMenu, UITableViewDelegate, UITableViewDataSource {
    
    struct Game {
        var date: String
        var formattedDate: String
        var time: String
        //var team: String
        var usersCalendar: [String] = []
        var usersNotification: [String] = []
        var teams: [Int] = []
        //var savedEventId: String = ""
        var savedNotificationId: String = ""
    }
    
    
    var gameList = [Game]()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Games"
        
        self.containerView.addSubview(self.tableView)
        
        var constraints: [NSLayoutConstraint] = []

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
        
        let db = Firestore.firestore()
        
        let games = db.collection("schedules").document("MLB").collection("games")
        games.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var counter = 0;
                    for document in querySnapshot!.documents {
                        let date = document.get("date") as! String
                        let formattedDate = document.get("formattedDate") as! String
                        let time = document.get("time") as! String
                        let usersCalender = document.get("usersCalendar") as! [String]
                        let usersNotification = document.get("usersNotification") as! [String]
                        let teams = document.get("teams") as! [Int]
                        
                        let tempGame = Game(date: date, formattedDate: formattedDate, time: time, usersCalendar: usersCalender, usersNotification: usersNotification, teams: teams, savedNotificationId: document.documentID)
                        //print(tempGame.savedNotificationId)
                        self.gameList.append(tempGame)
                        counter += 1
                        if counter % 5 == 0 {
                            //TODO: dispatch in Main thread
                            self.tableView.reloadData()
                        }
                    }
                    self.tableView.reloadData()
                }
        }
        
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
        let background: UIColor = currentUser!.settings!.dark ? .black : UIColor(rgb: Constants.Colors.lightOrange)
        let textColor: UIColor =  currentUser!.settings!.dark ? .white : .black
        
        if indexPath.row % 2 == 0 {
            let dateBackground: UIColor = currentUser!.settings!.dark ? UIColor(rgb: 0x060426) : UIColor(rgb: Constants.Colors.orange)
            let cell = tableView.dequeueReusableCell(withIdentifier: GameDateTableViewCell.identifier, for: indexPath) as! GameDateTableViewCell
            cell.contentView.backgroundColor = dateBackground
            let time = gameList[indexPath.row / 2].time
            cell.textLabel?.text = "\(gameList[indexPath.row / 2].date)\t\t\(time)"
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.identifier, for: indexPath) as! GameTableViewCell
        cell.textLabel?.text = ""
        let teamText = "\(mlb[gameList[indexPath.row / 2].teams[0]]) VS \(mlb[gameList[indexPath.row / 2].teams[1]])"
        //print(teamText)
        cell.displayLabel.text = teamText
        cell.textLabel?.textColor = textColor
        cell.displayLabel.textColor = textColor
        
        cell.index = indexPath.row / 2
        cell.delegate = self
        
        cell.notificationId = gameList[indexPath.row / 2].savedNotificationId
        
        cell.onCalendar =  gameList[indexPath.row / 2].usersCalendar.contains((currentUser?.userID)!)
        cell.onNotify =  gameList[indexPath.row / 2].usersNotification.contains((currentUser?.userID)!)
        
        cell.formattedDate = gameList[indexPath.row / 2].formattedDate
        
        let hash = (teamText + (cell.textLabel?.text)!).hashValue
        //print("hash \(hash)")
        let hashD = Double(abs(hash))
        //print("hashD \(hashD)")
        let identifer = hashD / pow(10, 17)
        //print("identifer \(identifer)")
        cell.uniqueIdentifer = identifer
        
        cell.updateColor(color: background)
        
        return cell
      
    }
    
    func updateCalendar (index: Int, remove: Bool) {
        let ID = (currentUser?.userID)!
        let game = gameList[index].savedNotificationId
        updateFireLeague(sport: "MLB", field: "usersCalendar", items: [ID], game: game, remove: remove)
        if remove {
            if let removeIndex = gameList[index].usersCalendar.firstIndex(of: ID){
                gameList[index].usersCalendar.remove(at: removeIndex)
            }
        } else {
            gameList[index].usersCalendar.append(ID)
        }
    }
    
    func updateNotification (index: Int, remove: Bool) {
        let ID = (currentUser?.userID)!
        let game = gameList[index].savedNotificationId
        updateFireLeague(sport: "MLB", field: "usersNotification", items: [ID], game: game, remove: remove)
        if remove {
            if let removeIndex = gameList[index].usersNotification.firstIndex(of: ID){
                gameList[index].usersNotification.remove(at: removeIndex)
            }
        } else {
            gameList[index].usersNotification.append(ID)
        }
    }
    
    func updateFireLeague(sport: String, field: String, items: [String], game: String, remove: Bool) {
        let db = Firestore.firestore()
        let ref = db.collection("schedules").document(sport)
        let docRef = ref.collection("games").document(game)
        
        if !remove {
            docRef.updateData([
                field: FieldValue.arrayUnion(items)
                ]){ error in
                if let e = error {
                    print("error updating fire user \(e.localizedDescription)")
                }
            }
        } else {
            docRef.updateData([
                field: FieldValue.arrayRemove(items)
                ]){ error in
                if let e = error {
                    print("error updating fire user \(e.localizedDescription)")
                }
            }
        }
    }
}
