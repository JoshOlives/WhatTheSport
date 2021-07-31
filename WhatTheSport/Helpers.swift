//
//  helpers.swift
//  WhatTheSport
//
//  Created by David Olivares on 7/10/21.
//

import Foundation
import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

class TextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setLeftPaddingPoints(10)
        self.setRightPaddingPoints(10)
    }

    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}

class SecureTextField: TextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSecureTextEntry = true
        self.textContentType = .oneTimeCode
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}

class LinkButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: Constants.Colors.orange).withAlphaComponent(0)
        self.setTitleColor(.blue, for: .normal)
    }
    
    convenience init(title: String) {
        self.init()
        let signInAttributes: [NSAttributedString.Key: Any] = [/*.underlineStyle: NSUnderlineStyle.single.rawValue, */ .font: UIFont.systemFont(ofSize: 18)]
        self.setAttributedTitle(NSMutableAttributedString(string: title, attributes: signInAttributes), for: .normal)
    }
    
    convenience init() {
        self.init(type: .roundedRect)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: Constants.Colors.orange)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 20.0
    }
    
    convenience init(title: String) {
        self.init()
        self.setTitle("Sign Up", for: .normal)
    }
    
    convenience init() {
        self.init(type: .roundedRect)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}

struct Constants {
    struct Colors {
        static let lightOrange = 0xfce9d4
        static let orange = 0xff9500
    }
    struct Defaults {
        //static let settings: NSDictionary = [Setting.setting1: false, Setting.setting2: false, Setting.setting3: false]
        //static let filters: NSDictionary = [Filter.filter1: false, Filter.filter2: false, Filter.filter3: false]
    }
    struct Field {
        static let spacing: CGFloat = 15.0
        static let height: CGFloat = 45.0
    }
}

struct UI {
    static func createAlert(title: String, msg: String) -> UIAlertController{
        let controller = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert)
        controller.addAction(UIAlertAction(
                                title: "OK",
                                style: .default,
                                handler: nil))
        return controller
    }
}
