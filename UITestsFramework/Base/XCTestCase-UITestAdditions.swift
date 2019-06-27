//
//  XCTestCase+UITestAdditions.swift
//  DepopUITests
//
//  Created by Tomek Kuzma on 29/11/2018.
//  Copyright © 2018 Depop. All rights reserved.
//


import XCTest

extension UITestCase {
    
    // Wait for an element to exist (does not need to be visible or on screen)
    func waitForElementToExist(_ element: XCUIElement, waitSeconds: TimeInterval = 30.0, filePath: String = #file, lineNumber: UInt = #line) {
        
        let existsPredicate = NSPredicate(format: "exists == true")
        
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: waitSeconds) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after waiting \(waitSeconds) seconds."
                self.takeScreenshot(with:self.app, name: message)
                self.recordFailure(withDescription: message, inFile: filePath, atLine: Int(lineNumber), expected: true)
            }
        }
    }
    
    // Wait for an element to not exist (does not need to be visible or on screen)
    func waitForElementToNotExist(_ element: XCUIElement, waitSeconds:
        
        TimeInterval = 30.0, filePath: String = #file, lineNumber: UInt = #line) {
        
        let existsPredicate = NSPredicate(format: "exists != true")
        
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: waitSeconds) { (error) -> Void in
            if (error != nil) {
                self.takeScreenshot(with:self.app)
                let message = "Failed. Element \(element) did not dissappear after waiting for \(waitSeconds) seconds."
                self.recordFailure(withDescription: message, inFile: filePath, atLine: Int(lineNumber), expected: true)
            }
        }
    }
    
    // Wait for an element to exist and be hittable (visible and on screen)
    func waitForElementToExistAndVisibleAndOnScreen(_ element: XCUIElement, waitSeconds: TimeInterval = 60.0, filePath: String = #file, lineNumber: UInt = #line) {
        
        let existsPredicate = NSPredicate(format: "hittable == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: waitSeconds) { (error) -> Void in
            
            if (error != nil) {
                self.takeScreenshot(with:self.app)
                let message = "Failed to find \(element) after waiting \(waitSeconds) seconds."
                self.recordFailure(withDescription: message,
                                   inFile: filePath, atLine: Int(lineNumber), expected: true)
            }
        }
    }
    
    // Wait until an element is no longer hittable (might still exist, but is either not visible or not on screen)
    func waitForElementToBecomeNotHittable(_ element: XCUIElement, waitSeconds: TimeInterval = 30.0, filePath: String = #file, lineNumber: UInt = #line) {
        let existsPredicate = NSPredicate(format: "hittable == false")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: waitSeconds) { (error) -> Void in
            if (error != nil) {
                self.takeScreenshot(with:self.app)
                let message = "Failed to find \(element) after waiting \(waitSeconds) seconds."
                self.recordFailure(withDescription: message,
                                   inFile: filePath, atLine: Int(lineNumber), expected: true)
            }
        }
    }
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
    
}

extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
    }

    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }

    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
