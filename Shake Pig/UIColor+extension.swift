//
//  UIColor+extension.swift
//
//  Created by Milan Djordjevic on 2/10/20.
//  Copyright © 2020 miff.me All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func hex(_ value: Int, alpha: CGFloat = 1) -> UIColor {
        return UIColor(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    static func hex(_ value: String, alpha: CGFloat = 1) -> UIColor {
        let hex = value.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        return UIColor(
            red: CGFloat((int & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((int & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(int & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
