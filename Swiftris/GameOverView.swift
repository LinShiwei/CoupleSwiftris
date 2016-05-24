//
//  GameOverView.swift
//  Swiftris
//
//  Created by Linsw on 16/5/24.
//  Copyright © 2016年 Bloc. All rights reserved.
//

import UIKit

class GameOverView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
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
