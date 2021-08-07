//
//  TableViewCell.swift
//  GameList
//
//  Created by John Wang on 8/4/21.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    static let identifier = "GameCell"
    
    let displayLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var constraints: [NSLayoutConstraint] = []
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(displayLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -200))
        constraints.append( displayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
  
       // toggle.addTarget(self, action: #selector(followedTeamsSwithch), for: .valueChanged)
        NSLayoutConstraint.activate(constraints)
        //displayLabel.frame = CGRect(x: 250, y:0, width: 150, height: contentView.frame.size.height)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(displayLabel)
      
        displayLabel.textAlignment = .right
       // contentView.backgroundColor = UIColor(rgb: Constants.Colors.lightOrange)
      

        //userInformationLabel.text = " user Infor"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateColor(color: UIColor) {
        contentView.backgroundColor = color
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
