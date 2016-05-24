//
//  GuideView.swift
//  Swiftris
//
//  Created by Linsw on 16/5/24.
//  Copyright © 2016年 Bloc. All rights reserved.
//

import UIKit

class GuideView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    weak var viewController : GameViewController?
    @IBAction func speedModeBtnTap(sender: UIButton) {
        if let controller = viewController {
            controller.gameMode = .Speed
            removeFromSuperviewWithAnimate()
        }
    }
    @IBAction func survivalModeBtnTap(sender: UIButton) {
        if let controller = viewController {
            controller.gameMode = .Survival
            removeFromSuperviewWithAnimate()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor(white: 0.9, alpha: 0.5)
        frame = windowBounds
    }
    private func removeFromSuperviewWithAnimate() {
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { void in
                self.alpha = 0
            }, completion: { (finish) in
                self.removeFromSuperview()
        })
    }
}
