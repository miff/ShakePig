//
//  GameScene.swift
//  Shake Pig
//
//  Created by Milan Djordjevic on 4/21/20.
//  Copyright © 2020 miff.me. All rights reserved.
//

import AVFoundation
import CoreMotion
import SpriteKit

class GameScene: SKScene {
    
    lazy var pig: SKButton = {
        let s = SKButton(texture: SKTexture(imageNamed: "Pig"))
        s.zPosition = 1
        s.position = .zero
        s.delegate = self
        return s
    }()
    
    lazy var eyes: EyesNode = {
        let e = EyesNode()
        e.build()
        e.position = .zero
        e.setScale(0.65)
        e.isHidden = true
        e.zPosition = 10
        e.delegate = self
        return e
    }()
    
    var pts: Int = 0 {
        didSet {
            ptsLbl.text = "\(pts)"
        }
    }
    
    var ptsLbl = SKLabelNode()
    var isGameOver: Bool = false
    var isLooking: Bool = false
    var prevAcc: CMAcceleration = .init(x: 0, y: 0, z: 0)
    var motionOffset: Double = 0.75
  
    let motionManager = CMMotionManager()
    
    override func sceneDidLoad() {
        [eyes, pig].forEach { addChild($0) }
        
        ptsLbl = childNode(withName: "//ptsLbl") as! SKLabelNode
        ptsLbl.text = "0"
        ptsLbl.position.y = safeArea.maxY - 80
        
    }
    
    override func didMove(to view: SKView) {
        motionManager.startAccelerometerUpdates()
    }
    
    func shake() {
        if isGameOver { return }
        if isLooking {
            isGameOver = true
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            
            let p = UserDefaults.standard.value(forKey: "PTS") as? Int ?? 0
            UserDefaults.standard.set(max(p, pts), forKey: "PTS")
            
            let vc = MenuScene(size: CGSize(width: 768, height: 1024))
            vc.scaleMode = .aspectFill
            vc.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            let transition: SKTransition = .crossFade(withDuration: 1)
            view?.presentScene(vc, transition: transition)
            return
        }
        
        AudioServicesPlaySystemSound(1102)
        let coin = SKSpriteNode(texture: SKTexture(imageNamed: "Coin"))
        coin.position = CGPoint(x: -20, y: 135)
        coin.zPosition = CGFloat.random(in: 0...2)
        addChild(coin)
        
        coin.run(.sequence([
            .move(to: CGPoint(x: CGFloat.random(in: -35...35), y: 185), duration: 0.4),
            .move(to: CGPoint(x: CGFloat.random(in: safeArea.minX...safeArea.maxX), y: safeArea.minY - 30), duration: 0.6),
            .removeFromParent()
        ])) {
            self.pts += 1
        }
        
        pig.run(.sequence([
            .repeat(.move(to: CGPoint(x: CGFloat.random(in: -30...30), y: CGFloat.random(in: -30...30)), duration: 0.1), count: 2),
            .move(to: .zero, duration: 0.1)
        ]))
    }
    
    override func update(_ currentTime: TimeInterval) {
        if isGameOver { return }
        
        if let accelerometerData = motionManager.accelerometerData {
            let curAcc = accelerometerData.acceleration
            
            if abs(curAcc.x) - abs(prevAcc.x) > motionOffset ||
                abs(curAcc.y) - abs(prevAcc.y) > motionOffset ||
                abs(curAcc.z) - abs(prevAcc.z) > motionOffset {
                shake()
            }
            
            prevAcc = accelerometerData.acceleration
        }
        
        let r = Int.random(in: 0...700)
        if r == 1 {
            if isLooking { return }
            isLooking = true
            motionOffset = 0.2
            pig.isHidden = true
            eyes.isHidden = false
            eyes.lookAround()
        }
        
    }
}

extension GameScene: SKButtonDelegate {
    func onTapSKBtn(with btn: SKButton) {
        if btn == pig {
            shake()
        }
    }
    
    
}

extension GameScene: EyesDelegate {
    func onLookingEnd() {
        isLooking = false
        pig.isHidden = false
        eyes.isHidden = true
        motionOffset = 0.75
    }
    
    
}
