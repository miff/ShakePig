//
//  MenuScene.swift
//  Shake Pig
//
//  Created by Milan Djordjevic on 4/21/20.
//  Copyright © 2020 miff.me. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    lazy var homeBgr: SKSpriteNode = {
        let s = SKSpriteNode(texture: SKTexture(imageNamed: "Home"))
        s.zPosition = 2
        s.position = .zero
        return s
    }()
    
    lazy var littlePig: SKSpriteNode = {
        let s = SKSpriteNode(texture: SKTexture(imageNamed: "Pig"))
        s.zPosition = 20
        s.position = CGPoint(x: safeArea.minX - 100, y: 240)
        s.setScale(0.2)
        return s
    }()
    
    lazy var playBtn: SKButton = {
        let b = SKButton(texture: SKTexture(imageNamed: "PlayBtn"))
        b.position = CGPoint(x: 0, y: -280)
        b.delegate = self
        return b
    }()
    
    lazy var settingsBtn: SKButton = {
        let b = SKButton(texture: SKTexture(imageNamed: "SettingsBtn"))
        b.position = CGPoint(x: 94, y: -280)
        b.delegate = self
        return b
    }()
    
    lazy var shopBtn: SKButton = {
        let b = SKButton(texture: SKTexture(imageNamed: "ShopBtn"))
        b.position = CGPoint(x: -94, y: -280)
        b.delegate = self
        return b
    }()
    
    lazy var ptsLbl: SKLabelNode = {
        let l = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        l.horizontalAlignmentMode = .center
        l.verticalAlignmentMode = .center
        l.fontSize = 64
        l.fontColor = .white
        l.position = CGPoint(x: 0, y: safeArea.maxY - 80)
        return l
    }()
    
    var pts: Int = 0 {
        didSet {
            ptsLbl.text = "\(pts)"
        }
    }
    
    override func sceneDidLoad() {
        [homeBgr, playBtn, settingsBtn, shopBtn, ptsLbl].forEach { addChild($0) }
        
        for (k, v) in [shopBtn, playBtn, settingsBtn].enumerated() {
            v.run(.sequence([
                .moveTo(y: 120, duration: 0.5 + (0.3 * Double(k))),
                .moveTo(y: 100, duration: 0.2)
            ])) {
                v.zPosition = 10
            }
        }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.hex("#0E2955")
        pts = UserDefaults.standard.value(forKey: "PTS") as? Int ?? 0
        animateLittlePig()
        if let particles = SKEmitterNode(fileNamed: "FxCoin.sks") {
            particles.zPosition = -1
            particles.position = CGPoint(x: safeArea.midX, y: safeArea.maxY)
            particles.advanceSimulationTime(60)
            addChild(particles)
        }
    }
    
    func animateLittlePig() {
        addChild(littlePig)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(to: CGPoint(x: 300, y: 0), controlPoint: CGPoint(x: 160, y: 220))
        path.addQuadCurve(to: CGPoint(x: 600, y: 0), controlPoint: CGPoint(x: 450, y: 200))
        path.addQuadCurve(to: CGPoint(x: 0, y: 0), controlPoint: CGPoint(x: 300, y: 300))

        let follow: SKAction = .follow(path.cgPath, asOffset: true, orientToPath: true, speed: 300)
        
        littlePig.run(.repeatForever(
            follow.reversed()
        ))
        
    }
    
}


extension MenuScene: SKButtonDelegate {
    func onTapSKBtn(with btn: SKButton) {
        if btn == playBtn {
            let vc = GameScene(fileNamed: "GameScene")!
            vc.scaleMode = .aspectFill
            let transition: SKTransition = .crossFade(withDuration: 1)
            view?.presentScene(vc, transition: transition)
        }
    }
    
}
