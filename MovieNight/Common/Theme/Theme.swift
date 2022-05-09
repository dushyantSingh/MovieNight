//
//  Theme.swift
//  MovieNight
//
//  Created by Dushyant Singh on 9/5/22.
//

import Foundation
import UIKit

struct Theme {
    struct Color {
        static let brickRedColor = UIColor(named: "brickRedColor")
        static let primaryColor = UIColor(named: "primaryColor")
        static let textFieldBorderColor = UIColor(named: "textFieldBorder")
    }
    struct Font {
        static func thinFont(with size: CGFloat) -> UIFont {
            return UIFont(name: "HelveticaNeue-Thin", size: size)!
        }
        static func boldFont(with size: CGFloat) -> UIFont {
            return UIFont(name: "HelveticaNeue-Medium", size: size)!
        }
        static func regularFont(with size: CGFloat) -> UIFont {
            return UIFont(name: "HelveticaNeue", size: size)!
        }
    }
}
