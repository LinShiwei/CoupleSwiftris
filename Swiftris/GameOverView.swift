//
//  GameOverView.swift
//  Swiftris
//
//  Created by Linsw on 16/5/24.
//  Copyright © 2016年 Bloc. All rights reserved.
//

import UIKit

enum Player{
    case PlayerOne
    case PlayerTwo
    case None
}

class GameOverView: UIView {

    var winner : Player? {
        didSet{
            switch winner!{
            case .PlayerOne:
                playerWinLabel.text = "Play One Win!"
            case .PlayerTwo:
                playerWinLabel.text = "Play Two Win!"
            case .None:
                playerWinLabel.text = "A Draw!"
            }
        }
    }
    @IBOutlet weak var playerWinLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor(white: 0.9, alpha: 0.5)
        frame = windowBounds
        alpha = 0
    }
    
    func presentWithAnimation(){
        UIView.animateWithDuration(1, delay: 0, options: .CurveEaseInOut, animations: { void in
                self.alpha = 1
            }, completion: { (finish) in
                
        })
    }
}
