//
//  SKScene+extension.swift
//
//  Created by Milan Djordjevic on 2/20/20.
//  Copyright © 2020 miff.me All rights reserved.
//

import SpriteKit

extension SKScene {
    
    /// Returns a CGRect of a safe area
    ///
    /// Depends on orientation of the device,
    /// calculate a safe area and
    /// creates a rectangle with coordinates and dimensions based on calculation
    /// specified as floating-point values.
    ///
    var safeArea: CGRect {
        get {
            if UIApplication.shared.statusBarOrientation.isPortrait {
                let ratio: CGFloat = UIScreen.main.bounds.height / UIScreen.main.bounds.width
                let safeWidth = size.height / ratio
                let safeMargin = (size.width - safeWidth) / 2
                return CGRect(x: safeMargin - (size.width / 2), y: -(size.height / 2), width: safeWidth, height: size.height)
            } else {
                let ratio: CGFloat = UIScreen.main.bounds.width / UIScreen.main.bounds.height
                let safeHeight = size.width / ratio
                let safeMargin = (size.height - safeHeight) / 2
                return CGRect(x: 0, y: safeMargin, width: size.width, height: safeHeight)
            }
        }
        
        set { }
    }
    
    /// Draw a DEBUG safe area
    ///
    /// - Parameters: none
    func debugSafeArea() {
        let shape = SKShapeNode(rect: safeArea)
        shape.strokeColor = SKColor.red
        shape.lineWidth = 4
        addChild(shape)
    }
}
