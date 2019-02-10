//
//  iSportUITests.swift
//  iSportUITests
//
//  Created by Gianluigi Oliva on 13/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import XCTest

class iSportUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.

        app = XCUIApplication()
        
//         We send a command line argument to our app,
//         to enable it to reset its state
//        app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        app.launch()
//
//
//
//        let tableNews = app.tables.element(boundBy: 0)
//        let cella = tableNews.cells.element(boundBy: 0)
//        cella.tap()
//        let app = XCUIApplication()
//        let tablesQuery = app.tables
//        tablesQuery.cells.containing(.staticText, identifier:"www.gazzetta.it").children(matching: .button).element(boundBy: 0).tap()
//        app.navigationBars["iSport.NewsView"].children(matching: .button).element(boundBy: 2).tap()
//        tablesQuery.cells.containing(.staticText, identifier:"www.tuttomercatoweb.com").children(matching: .textView).element.swipeUp()
//        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).tables.children(matching: .cell).element(boundBy: 5).children(matching: .textView).element.tap()
//        app.navigationBars.buttons["Done"].tap()
        
    }

}
