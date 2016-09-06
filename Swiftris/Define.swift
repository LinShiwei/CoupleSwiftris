//
//  Define.swift
//  Swiftris
//
//  Created by Linsw on 16/5/22.
//  Copyright © 2016年 Bloc. All rights reserved.
//

import Foundation
import UIKit
let windowBounds = UIScreen.mainScreen().bounds

let BlockSize : CGFloat = windowBounds.width/2/16

let TickLengthLevelOne = NSTimeInterval(600)

let survivalTimeLimit = 60

let NumColumns = 10
let NumRows = 20

let StartingColumn = 4
let StartingRow = 0

let PreviewColumn = 12
let PreviewRow = 1

let PointsPerLine = 10
let LevelThreshold = 500
