//
//  GameOverScene.swift
//  Shake Pig
//
//  Created by Milan Djordjevic on 4/22/20.
//  Copyright © 2020 miff.me. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    lazy var eyes: EyesNode = {
        let e = EyesNode()
        e.build()
        e.position = .zero
        e.setScale(0.65)
        e.zPosition = 10
        e.idle()
        return e
    }()
    
    lazy var ptsLbl: SKLabelNode = {
        let l = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        l.horizontalAlignmentMode = .center
        l.verticalAlignmentMode = .center
        l.fontSize = 64
        l.fontColor = .white
        l.position = CGPoint(x: 0, y: safeArea.maxY - 300)
        return l
    }()
    
    lazy var ptsTitleLbl: SKLabelNode = {
        let l = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        l.horizontalAlignmentMode = .center
        l.verticalAlignmentMode = .center
        l.fontSize = 64
        l.fontColor = .white
        l.position = CGPoint(x: 0, y: safeArea.maxY - 220)
        l.text = "YOUR SCORE"
        return l
    }()
    
    lazy var highScoreLbl: SKLabelNode = {
        let l = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        l.horizontalAlignmentMode = .center
        l.verticalAlignmentMode = .center
        l.fontSize = 94
        l.fontColor = .yellow
        l.position = CGPoint(x: 0, y: safeArea.maxY - 100)
        return l
    }()
    
    lazy var playBtn: SKButton = {
        let b = SKButton(texture: SKTexture(imageNamed: "PlayBtn"))
        b.position = CGPoint(x: 0, y: safeArea.minY - 70)
        b.delegate = self
        return b
    }()
    
    var pts: Int = 0 {
        didSet {
            ptsLbl.text = "\(pts)"
        }
    }
    
    var highScore: Int = 0 {
        didSet {
            highScoreLbl.text = "\(highScore)"
        }
    }
    
    override func sceneDidLoad() {
        [eyes, ptsLbl, ptsTitleLbl, highScoreLbl, playBtn].forEach { addChild($0) }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.hex("#0E2955")
        highScore = UserDefaults.standard.value(forKey: "PTS") as? Int ?? 0
        
        playBtn.run(.sequence([
            .wait(forDuration: 0.5),
            .moveTo(y: safeArea.minY + 200, duration: 0.5),
            .moveTo(y: safeArea.minY + 180, duration: 0.2)
        ]))
    }
}

extension GameOverScene: SKButtonDelegate {
    func onTapSKBtn(with btn: SKButton) {
        if btn == playBtn {
            let vc = MenuScene(size: CGSize(width: 768, height: 1024))
            vc.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            vc.scaleMode = .aspectFill
            let transition: SKTransition = .crossFade(withDuration: 1)
            view?.presentScene(vc, transition: transition)
        }
    }
    
    
}
