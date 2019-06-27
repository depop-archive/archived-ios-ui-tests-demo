//
//  UITestCase.swift
//  DepopUITests
//
//  Created by Tomek Kuzma on 29/11/2018.
//  Copyright © 2018 Depop. All rights reserved.
//


import XCTest

typealias UITestContext = (app: XCUIApplication, testCase: UITestCase)

// Base class for UI tests
// sets up up default environment and launches the app in the setup
// terminates app at tearDown. Has context that screen models can easily access

extension XCTestCase {
    func takeScreenshot(with app: XCUIApplication, name: String = "") {
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = .keepAlways
        attachment.name = name
        attachment.userInfo = ["context" : name]
        add(attachment)
    }
}

class UITestCase: XCTestCase {
    
    private(set) var app: XCUIApplication!
	var envvars = [String:String]() // additional env vars that subclasses can modify
    
    var context: UITestContext {
        return (app: app, testCase: self)
    }
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        launchApp()
    }

    override func tearDown() {
        app.terminate()
        super.tearDown()
    }
    
    fileprivate func launchApp() {
        app = XCUIApplication()
		let env = ["DISABLE_ANIMATIONS": "1"].merging(envvars) { (_, new) -> String in new }
        app.launchEnvironment = env
        app.launch()
    }
}
