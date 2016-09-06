//
//  GuideView.swift
//  Swiftris
//
//  Created by Linsw on 16/5/24.
//  Copyright © 2016年 Bloc. All rights reserved.
//

import UIKit

class GuideView: UIView {

    weak var viewController : GameViewController?
    @IBOutlet weak var survivalModeBtn: UIButton!
    @IBOutlet weak var speedModeBtn: UIButton!
    
    @IBAction func speedModeBtnTap(sender: UIButton) {
        if let controller = viewController {
            controller.gameMode = .Speed
            sender.backgroundColor = UIColor(white: 0.5, alpha: 1)
            removeFromSuperviewWithAnimate()
        }
    }
    @IBAction func survivalModeBtnTap(sender: UIButton) {
        if let controller = viewController {
            controller.gameMode = .Survival
            sender.backgroundColor = UIColor(white: 0.5, alpha: 1)
            removeFromSuperviewWithAnimate()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor(white: 0.9, alpha: 0.5)
        frame = windowBounds
    }
    override func awakeFromNib() {
        configureButton(survivalModeBtn)
        configureButton(speedModeBtn)
    }
    private func configureButton(button:UIButton){
        button.bounds = CGRect(x: 0, y: 0, width: windowBounds.width/10, height: windowBounds.width/10)
        button.layer.cornerRadius = 10
        
    }
    private func removeFromSuperviewWithAnimate() {
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { void in
                self.alpha = 0
            }, completion: { (finish) in
                self.removeFromSuperview()
        })
    }
}
