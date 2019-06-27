//
//  DetailScreenModel.swift
//  UITestsDemo
//
//  Created by Russell Yeo on 26/06/2019.
//  Copyright © 2019 Russell Yeo. All rights reserved.
//

import XCTest

class DetailScreen: ScreenModel {
    
    private var detailLabel: XCUIElement {
        return app
            .textFields
            .matching(identifier: "detail.description.label")
            .firstMatch
    }
    
    func assertDetailLabel(matches string: String) {
        XCTAssertEqual(detailLabel.exists, true)
        XCTAssertEqual(detailLabel.label, string)
    }
    
}
