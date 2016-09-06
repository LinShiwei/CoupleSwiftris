//
//  LevelView.swift
//  Swiftris
//
//  Created by Linsw on 16/5/22.
//  Copyright © 2016年 Bloc. All rights reserved.
//

import UIKit

class InfoView: UIView {

    var number = 0 {
        didSet{
            if let label = numberLabel {
                if number < 0 {
                    label.text = "-"
                }else{
                    label.text = String(number)
                }
            }
        }
    }
    var title = "" {
        didSet{
            if let label = titleLabel {
                label.text = title
            }
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5        
    }
    
    override func awakeFromNib() {
        titleLabel.adjustsFontSizeToFitWidth = true
        numberLabel.adjustsFontSizeToFitWidth = true
        
    }
}
