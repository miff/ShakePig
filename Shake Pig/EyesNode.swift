//
//  EyesNode.swift
//  Shake Pig
//
//  Created by Milan Djordjevic on 4/21/20.
//  Copyright © 2020 miff.me. All rights reserved.
//

import SpriteKit

protocol EyesDelegate {
    func onLookingEnd()
}

class EyesNode: SKSpriteNode {
    
    var eyes = SKSpriteNode()
    var eyesFrames: [SKTexture] = []
    
    var bar = SKSpriteNode()
    var loader = SKSpriteNode()
    
    var delegate: EyesDelegate?
    
    var time: TimeInterval = 5 {
        didSet {
            
        }
    }
   
    func build() {
        // Eyes
        let atlas = SKTextureAtlas(named: "Eyes")
        var lookFrames: [SKTexture] = []
        
        let numImages = atlas.textureNames.count
        
        for i in 1...numImages - 1 {
            let texName = "Eye\(i)"
            lookFrames.append(atlas.textureNamed(texName))
        }
        
        eyesFrames = lookFrames
        
        let firstFrameTexture = eyesFrames[0]
        eyes = SKSpriteNode(texture: firstFrameTexture)
        eyes.position = .zero
        addChild(eyes)
        
        // Bar
        bar = SKSpriteNode(texture: SKTexture(imageNamed: "Bar"))
        bar.position = CGPoint(x: 0, y: -250)
        
        loader = SKSpriteNode(texture: SKTexture(imageNamed: "Loader"))
        loader.anchorPoint = CGPoint(x: 0, y: 0.5)
        loader.position = CGPoint(x: -190, y: 0)
        loader.zPosition = 1
        bar.addChild(loader)
        
        addChild(bar)
    }
    
    func idle() {
        eyes.run(.repeatForever(.animate(with: eyesFrames, timePerFrame: 0.2,  resize: false, restore: false)), withKey:"lookAround")
    }
    
    func lookAround() {
        eyes.run(.repeatForever(.animate(with: eyesFrames, timePerFrame: 0.2,  resize: false, restore: false)), withKey:"lookAround")
        
        loader.run(.scaleX(to: 0, duration: time)) {
            self.eyes.removeAllActions()
            self.isHidden = true
            if self.delegate != nil { self.delegate?.onLookingEnd() }
            self.loader.setScale(1)
        }
    }
    
}
