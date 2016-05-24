//
//  SwiftrisTests.swift
//  SwiftrisTests
//
//  Created by Stanley Idesis on 7/14/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

import UIKit
import XCTest
@testable import Swiftris
class SwiftrisTests: XCTestCase {
    var gameViewController : GameViewController!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GameViewController") as! GameViewController
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    func testGameViewClass(){
//        var gameView : GameView?
//        for view in gameViewController.view.subviews where view is UIStackView {
//            for v in (view as! UIStackView).subviews where v is GameView{
//                gameView = (v as! GameView)
//                XCTAssertNotNil(gameView!.levelView)
//                gameView?.delegate = gameViewController
//                print(gameView!.levelView)
//            }
//        }
//        XCTAssertNotNil(gameView)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
