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
            switch gameMode! {
            case .Speed:
                initGameViewTimer(true)
            case .Survival:
                initGameViewTimer(false)
            }
            
            skViewLeft.beginGame(withDelegate: self)
            skViewRight.beginGame(withDelegate: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        skViewLeft.player = .PlayerOne
        skViewRight.player = .PlayerTwo
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
    
    private func addGameOverView(withWinner winner:Player){
        guard let viewFromNib = NSBundle.mainBundle().loadNibNamed("GameOverView", owner: nil, options: nil).first as? GameOverView else{return}
        gameOverView = viewFromNib
        view.addSubview(gameOverView!)
        gameOverView!.winner = winner
        gameOverView!.presentWithAnimation()
        let recognizer = UITapGestureRecognizer(target: self, action: "tapToRestart:")
        gameOverView!.addGestureRecognizer(recognizer)
    }
    
    func tapToRestart(sender:UITapGestureRecognizer){
        
        gameOverView?.removeFromSuperview()
        addGuideView()
    }
    
    private func initGameViewTimer(enable: Bool){
        if enable {
            guard GameView.timer == nil || GameView.timer?.valid == false else{return}
            GameView.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countDown", userInfo: nil, repeats: true)
            skViewRight.timeInSecond = survivalTimeLimit
            skViewLeft.timeInSecond = survivalTimeLimit
        }else{
            skViewRight.timeInSecond = -1
            skViewLeft.timeInSecond = -1
        }
    }
    
    func countDown(){
        if let _ = skViewRight.timeInSecond{
            if skViewRight.timeInSecond > 0 {
                skViewRight.timeInSecond! -= 1
            }else{
                if let score1 = skViewLeft.score, score2 = skViewRight.score {
                    if score1 < score2 {
                        skViewLeft.endGame()
                    }else{
                        if score2 < score1{
                            skViewRight.endGame()
                        }else{
                            oneGameEnd(nil)
                        }
                    }
                }
            }
            skViewLeft.timeInSecond = skViewRight.timeInSecond
        }
    }
}
extension GameViewController: GameControlDelegate {
    func oneGameEnd(gameView: GameView?) {
        GameView.timer?.invalidate()
        skViewLeft.delegate = nil
        skViewRight.delegate = nil
        
        if gameView == nil {
            skViewLeft.endGame()
            skViewRight.endGame()
            addGameOverView(withWinner: .None)
        }else{
            if gameView === skViewRight {
                skViewLeft.endGame()
                addGameOverView(withWinner: .PlayerOne)
            }else{
                if gameView === skViewLeft {
                    skViewRight.endGame()
                    addGameOverView(withWinner: .PlayerTwo)
                }else{
                    print("Function oneGameEnd met a Error")
                }
            }
        }
    }
}
