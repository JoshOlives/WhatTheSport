//
//  SettingToggleTableViewCell.swift
//  FinalProject
//
//  Created by John Wang on 8/2/21.
//

import UIKit

class SettingToggleTableViewCell: SettingTableViewCell {
    
    let toggle = UISwitch()
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        toggle.frame = CGRect(x: 350, y: contentView.frame.midY - toggle.frame.size.height / 2, width: 150, height: contentView.frame.size.height)
        var constraints: [NSLayoutConstraint] = []
        toggle.translatesAutoresizingMaskIntoConstraints = false
        constraints.append( toggle.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15))
        constraints.append( toggle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        toggle.isOn = false
       // toggle.addTarget(self, action: #selector(followedTeamsSwithch), for: .valueChanged)
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(toggle)

        contentView.layer.addSublayer(border)
        contentView.layer.masksToBounds = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
