//
//  GameViewController.swift
//  Shake Pig
//
//  Created by Milan Djordjevic on 4/21/20.
//  Copyright © 2020 miff.me. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let vc = MenuScene(size: CGSize(width: 768, height: 1024))
            vc.scaleMode = .aspectFill
            vc.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            view.presentScene(vc)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
