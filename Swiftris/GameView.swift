//
//  GameView.swift
//  Swiftris
//
//  Created by Linsw on 16/5/22.
//  Copyright © 2016年 Bloc. All rights reserved.
//

import UIKit
import SpriteKit

class GameView: SKView{

    private var gameScene : GameScene!
    private var swiftris : Swiftris!
    private var levelView : InfoView!
    private var scoreView : InfoView!
    private var timeView: InfoView!
    private var timer : NSTimer?
    private var panPointReference : CGPoint?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        multipleTouchEnabled = false
        autoresizesSubviews = false
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "didPan:")
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "didSwipe:")
        swipeGestureRecognizer.direction = .Down
        swipeGestureRecognizer.delegate = self
        addGestureRecognizer(swipeGestureRecognizer)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didTap:")
        tapGestureRecognizer.delegate = self
        addGestureRecognizer(tapGestureRecognizer)
        
        layer.borderColor = UIColor.greenColor().CGColor
        layer.borderWidth = 5

        
    }
    override func awakeFromNib() {
        addLevelView()
        addScoreView()
        addTimeView()   
        
        gameScene = GameScene(size: CGSize(width: windowBounds.width/2, height: windowBounds.height))
        gameScene.scaleMode = .ResizeFill
        assert(windowBounds.width > windowBounds.height, "width is shorter than height")
        assert(gameScene.size.width == windowBounds.width/2)
        assert(gameScene.size.height == windowBounds.height)
        
        swiftris = Swiftris()
        swiftris.scene = gameScene
        swiftris.delegate = self
        swiftris.beginGame()
        presentScene(gameScene)
        
        
    }
    private func addLevelView(){
        guard let viewFromNib = NSBundle.mainBundle().loadNibNamed("InfoView", owner: nil, options: nil).first as? InfoView else{return}
        levelView = viewFromNib
        levelView.frame = CGRect(x: BlockSize*11, y: BlockSize*12, width: BlockSize*4, height: BlockSize*5)
        levelView.title = "LEVEL"
        addSubview(levelView)
    }
    
    private func addScoreView(){
        guard let viewFromNib = NSBundle.mainBundle().loadNibNamed("InfoView", owner: nil, options: nil).first as? InfoView else{return}
        scoreView = viewFromNib
        scoreView.frame = CGRect(x: BlockSize*11, y: BlockSize*18, width: BlockSize*4, height: BlockSize*5)
        scoreView.title = "SCORE"
        addSubview(scoreView)
    }
    
    private func addTimeView(){
        guard let viewFromNib = NSBundle.mainBundle().loadNibNamed("InfoView", owner: nil, options: nil).first as? InfoView else{return}
        timeView = viewFromNib
        timeView.frame = CGRect(x: BlockSize*11, y: BlockSize*6, width: BlockSize*4, height: BlockSize*5)
        timeView.title = "TIME"
        timeView.number = 60
        addSubview(timeView)
    }
    func initTimer(){
        guard timer == nil || timer?.valid == false else{return}
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countDown", userInfo: nil, repeats: true)

    }
    func countDown(){
        if timeView.number > 0 {
            timeView.number -= 1
        }else{
            timeView.number = 60
        }
    }
    func didPan(sender:UIPanGestureRecognizer){
        let currentPoint = sender.translationInView(self)
        if let originalPoint = panPointReference {
            if abs(currentPoint.x - originalPoint.x) > (BlockSize * 0.9) {
                if sender.velocityInView(self).x > CGFloat(0) {
                    swiftris.moveShapeRight()
                    panPointReference = currentPoint
                } else {
                    swiftris.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        } else if sender.state == .Began {
            panPointReference = currentPoint
        }
    }
    
    func didSwipe(sender:UISwipeGestureRecognizer){
        swiftris.dropShape()
    }
    
    func didTap(sender:UITapGestureRecognizer){
        swiftris.rotateShape()
        print(levelView.frame)

    }
}
extension GameView : UIGestureRecognizerDelegate{
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        if gestureRecognizer is UISwipeGestureRecognizer {
//            if otherGestureRecognizer is UIPanGestureRecognizer {
//                return true
//            }
//        } else if gestureRecognizer is UIPanGestureRecognizer {
//            if otherGestureRecognizer is UITapGestureRecognizer {
//                return true
//            }
//        }
//        if gestureRecognizer is UISwipeGestureRecognizer && otherGestureRecognizer is UIPanGestureRecognizer {
//            return true
//        }
        return false
    }
}
extension GameView : SwiftrisDelegate{
    func nextShape(swiftris:Swiftris) {
        let newShapes = swiftris.newShape()
        guard let fallingShape = newShapes.fallingShape else {
            return
        }
        swiftris.scene!.addPreviewShapeToScene(newShapes.nextShape!) {}
        swiftris.scene!.movePreviewShape(fallingShape) {
            self.userInteractionEnabled = true
            swiftris.scene!.startTicking()
        }
    }
    
    func gameDidBegin(swiftris: Swiftris) {
        levelView.number = swiftris.level
        scoreView.number = swiftris.score
        swiftris.scene!.tickLengthMillis = TickLengthLevelOne
        
        // The following is false when restarting a new game
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            swiftris.scene!.addPreviewShapeToScene(swiftris.nextShape!) {
                self.nextShape(swiftris)
            }
        } else {
            nextShape(swiftris)
        }
    }
    
    func gameDidEnd(swiftris: Swiftris) {
        userInteractionEnabled = false
        swiftris.scene!.stopTicking()
        swiftris.scene!.playSound("Sounds/gameover.mp3")
        swiftris.scene!.animateCollapsingLines(swiftris.removeAllBlocks(), fallenBlocks: swiftris.removeAllBlocks()) {
            swiftris.beginGame()
        }
    }
    
    func gameDidLevelUp(swiftris: Swiftris) {
        levelView.number = swiftris.level
        if swiftris.scene!.tickLengthMillis >= 100 {
            swiftris.scene!.tickLengthMillis -= 100
        } else if swiftris.scene!.tickLengthMillis > 50 {
            swiftris.scene!.tickLengthMillis -= 50
        }
        swiftris.scene!.playSound("Sounds/levelup.mp3")
    }
    
    func gameShapeDidDrop(swiftris: Swiftris) {
        swiftris.scene!.stopTicking()
        swiftris.scene!.redrawShape(swiftris.fallingShape!) {
            swiftris.letShapeFall()
        }
        swiftris.scene!.playSound("Sounds/drop.mp3")
    }
    
    func gameShapeDidLand(swiftris: Swiftris) {
        swiftris.scene!.stopTicking()
        userInteractionEnabled = false
        let removedLines = swiftris.removeCompletedLines()
        if removedLines.linesRemoved.count > 0 {
            self.scoreView.number = swiftris.score
            swiftris.scene!.animateCollapsingLines(removedLines.linesRemoved, fallenBlocks:removedLines.fallenBlocks) {
                self.gameShapeDidLand(swiftris)
            }
            swiftris.scene!.playSound("Sounds/bomb.mp3")
        } else {
            nextShape(swiftris)
        }

    }
    
    func gameShapeDidMove(swiftris: Swiftris) {
        swiftris.scene!.redrawShape(swiftris.fallingShape!) {}
    }
}