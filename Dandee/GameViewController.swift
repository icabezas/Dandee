//
//  GameViewController.swift
//  Dandee
//
//  Created by DAM2T1 on 23/4/18.
//  Copyright © 2018 Thor. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = SKSceneScaleMode.resizeFill
                // Present the scene
                view.presentScene(scene)
            }
            
            
            view.ignoresSiblingOrder = true
            
            // minimo 24 o 30 (óptimo 60 ¿?)
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
    }
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
