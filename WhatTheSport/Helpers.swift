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

struct Constants {
    struct Colors {
        static var lightOrange = 0xfce9d4
        static var orange = 0xff9500
    }
    struct Field {
        static var spacing: CGFloat = 15.0
        static var height: CGFloat = 45.0
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
