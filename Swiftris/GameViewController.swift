//
//  GameViewController.swift
//  Swiftris
//
//  Created by Stanley Idesis on 7/14/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

import UIKit
import SpriteKit

enum GameMode {
    case Speed
    case Survival
}
class GameViewController: UIViewController{
    
    @IBOutlet weak var skViewLeft: GameView!
    @IBOutlet weak var skViewRight: GameView!
    var guideView : GuideView?
    var gameOverView : GameOverView?
    var gameMode : GameMode?{
        didSet{
            skViewLeft.beginGame(withDelegate: self)
            skViewRight.beginGame(withDelegate: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addGuideView()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func addGuideView(){
        guard let viewFromNib = NSBundle.mainBundle().loadNibNamed("GuideView", owner: nil, options: nil).first as? GuideView else{return}
        guideView = viewFromNib
        guideView!.viewController = self
        view.addSubview(guideView!)
    }
    
    private func addGameOverView(){
        guard let viewFromNib = NSBundle.mainBundle().loadNibNamed("GameOverView", owner: nil, options: nil).first as? GameOverView else{return}
        gameOverView = viewFromNib
        view.addSubview(gameOverView!)
        gameOverView!.presentWithAnimation()
        let recognizer = UITapGestureRecognizer(target: self, action: "tapToRestart:")
        gameOverView!.addGestureRecognizer(recognizer)
    }
    
    func tapToRestart(sender:UITapGestureRecognizer){
        
        gameOverView?.removeFromSuperview()
        addGuideView()
    }
}
extension GameViewController: GameControlDelegate {
    func OneGameEnd(gameView: GameView) {
        
        skViewLeft.delegate = nil
        skViewRight.delegate = nil
        if gameView === skViewRight {
            skViewLeft.endGame()
        }else{
            if gameView === skViewLeft {
                skViewRight.endGame()
            }else{
                print("Function OneGameEnd met a Error")
            }
        }
        addGameOverView()
    }
}
