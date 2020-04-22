//
//  SKButton.swift
//
//  Created by Milan Djordjevic on 2/11/20.
//  Copyright © 2020 miff.me All rights reserved.
//

import SpriteKit
import GameplayKit

protocol SKButtonDelegate {
    func onTapSKBtn(with btn: SKButton)
}

class SKButton: SKSpriteNode {
    
    var delegate: SKButtonDelegate!
    var normalScale: CGFloat = 1
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.isUserInteractionEnabled = true
        normalScale = self.xScale
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let s: CGFloat = normalScale + (8 / 100)
        run(.scale(to: s, duration: 0.12))
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        run(.scale(to: normalScale, duration: 0.08))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        run(.scale(to: normalScale, duration: 0.08)) {
            if self.delegate != nil { self.delegate.onTapSKBtn(with: self) }
        }
    }
}
