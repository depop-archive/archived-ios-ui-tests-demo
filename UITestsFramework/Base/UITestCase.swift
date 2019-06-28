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
	var envVars = [String:String]() // additional env vars that subclasses can modify
    
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
        let defaultEnv = ["DISABLE_ANIMATIONS": "1",
                          "MOCKSERVER_URL": "http://localhost:1234"]
        app.launchEnvironment = defaultEnv.merging(envVars) { (_, new) -> String in new }
        app.launch()
    }
}
