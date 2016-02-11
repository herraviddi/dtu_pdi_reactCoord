//
//  GameViewController.swift
//  ReactCoord
//
//  Created by Vidar Fridriksson on 10/02/16.
//  Copyright (c) 2016 herraviddi. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController,UITextFieldDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = StartMenuScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
    
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
