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
            .tapAddNavBarButton(times: 5)
            .assertRow(at: 0, has: "5")
            .tapRow(at: 2)
            .assertDetailLabel(matches: "3")
    }
}
