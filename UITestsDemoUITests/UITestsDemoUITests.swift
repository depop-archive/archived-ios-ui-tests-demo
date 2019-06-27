//
//  UITestsDemoUITests.swift
//  UITestsDemoUITests
//
//  Created by Russell Yeo on 11/06/2019.
//  Copyright © 2019 Russell Yeo. All rights reserved.
//

import XCTest

class UITestsDemoUITests: UITestCase {

    func testNumberOfRows() {
        let _ = MasterScreen(context: context)
            .tapAddNavBarButton(times: 3)
            .assertNumberOfRows(number: 3)
    }
    
    func testTopRowLabel() {
        let _ = MasterScreen(context: context)
            .tapAddNavBarButton(times: 4)
            .assertTopRow(label: "4")
    }
    
    func assertDetailLabel() {
        let _ = MasterScreen(context: context)
            .tapAddNavBarButton(times: 5)
            .tapRow(at: 6)
            .assertDetailLabel(matches: "5")
    }
}
