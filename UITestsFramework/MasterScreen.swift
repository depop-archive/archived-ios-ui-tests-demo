//
//  MasterScreenModel.swift
//  UITestsDemo
//
//  Created by Russell Yeo on 26/06/2019.
//  Copyright © 2019 Russell Yeo. All rights reserved.
//

import XCTest

class MasterScreen: ScreenModel {
    
    private var addNavBarButton: XCUIElement {
        return app
            .navigationBars
            .firstMatch
            .buttons
            .matching(identifier: "master.navBarButton.add")
            .firstMatch
    }
    
    private func row(at index: Int) -> XCUIElement {
        return app
            .tables
            .cells
            .allElementsBoundByIndex[index]
            .firstMatch
    }
    
    private var allRows: [XCUIElement] {
        return app
            .tables
            .cells
            .allElementsBoundByAccessibilityElement
    }
    
    func tapAddNavBarButton(times: Int) -> MasterScreen {
        (0..<times).forEach { _ in addNavBarButton.tap() }
        return self
    }
    
    func tapRow(at index: Int) -> DetailScreen {
        row(at: index).tap()
        return DetailScreen(context: context)
    }
    
    func assertNumberOfRows(number: Int) {
        XCTAssertEqual(allRows.count, number)
    }
    
    func assertTopRow(label: String) {
        XCTAssertEqual(row(at: 0).staticTexts[label].exists, true)
    }
    
}
