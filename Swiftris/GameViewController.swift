//
//  GameViewController.swift
//  Swiftris
//
//  Created by Stanley Idesis on 7/14/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController{
    
    @IBOutlet weak var skViewLeft: GameView!
    @IBOutlet weak var skViewRight: GameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        assert(skViewLeft.delegate === skViewRight.delegate)
        
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
