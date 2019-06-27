//
//  ScreenModel.swift
//  DepopUITests
//
//  Created by Tomek Kuzma on 29/11/2018.
//  Copyright © 2018 Depop. All rights reserved.
//

import Foundation
import XCTest

// This is a base class for screen models
// It contains context so that it's easy to pass then from one screen to the next one
class ScreenModel {
    
    var app: XCUIApplication {
        return context.app
    }
    
    var testCase: UITestCase {
        return context.testCase
    }
    
    let context: UITestContext
    
    init(context: UITestContext) {
        self.context = context
        let screen = String(describing: self)
        print("screen \(screen) created")
    }

    func takeScreenshot(with title: String) -> Self {
        testCase.takeScreenshot(with: app, name: title)
        return self
    }
}
