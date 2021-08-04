//
//  ViewController.swift
//  FinalProject
//
//  Created by John Wang on 8/2/21.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    let settingDisplay = ["Account", "Push Notifications", "DarkMode", "Post Color", "App version"]
    var nextVC: AccountPageViewController!
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Settings"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: Constants.Colors.orange)
        
        var constraints: [NSLayoutConstraint] = []

       
        view.addSubview(tableView)

        self.tableView.tableFooterView = UIView(frame: .zero)
        
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.register(SettingToggleTableViewCell.self, forCellReuseIdentifier: SettingToggleTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor))
        constraints.append( tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor))
        //tableView.frame = CGRect(x: 0, y: 250, width: view.bounds.width, height: view.bounds.height - 500)
        tableView.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
        NSLayoutConstraint.activate(constraints)
        view.backgroundColor = UIColor(rgb: Constants.Colors.orange)
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        inTransition = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        if indexPath.row < 3 && indexPath.row > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingToggleTableViewCell.identifier, for: indexPath) as! SettingToggleTableViewCell
            cell.textLabel?.text = settingDisplay [indexPath.row]
            return cell

        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        //cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.red.cgColor
        cell.textLabel?.text = settingDisplay [indexPath.row]
        if ( indexPath.row == 0) {
            cell.displayLabel.isHidden = true
        }
        else if ( indexPath.row == 3) {
            cell.displayLabel.text = "Orange"
            
        }
        else {
            cell.displayLabel.text = "V.01"
        }
            
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        switch row {
        case 0:
            if inTransition {
                return
            } else {
                inTransition = true
            }
            print("this is row \(row)")
            if nextVC == nil{
                print("this is row at \(indexPath.row)")
                nextVC = AccountPageViewController()
            }
            
            if self.nextVC.profilePhoto.currentImage == nil {
                guard let urlstring = fireUser!.get("URL") as? String else{
                    print("error retreiving urlstring")
                    inTransition = false
                    return
                }
                let imageView = UIImageView()
                IO.downloadImage(str: urlstring, imageView: imageView){
                    self.nextVC.profilePhoto.setImage(imageView.image, for: .normal)
                    UI.transition(dest: self.nextVC, src: self)
                }
            } else {
                UI.transition(dest: self.nextVC, src: self)
                print("account view")
            }
        
        default:
            print("This should not happen.")
        }
        
      
    }


}

