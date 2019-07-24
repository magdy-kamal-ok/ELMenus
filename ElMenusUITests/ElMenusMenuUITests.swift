//
//  ElMenusUITests.swift
//  ElMenusUITests
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
@testable import ElMenus

class ElMenusMenuUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testTagListLoaded() {
        app.launch()
        let tableView = app.tables[Constants.tableViewIdentifier]
        XCTAssert(tableView.exists)

    }
    
    func testTagListCollectionViewExists()
    {
        app.launch()
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.firstMatch
        firstCell.isAccessibilityElement = true
        let collectionView = firstCell.descendants(matching: .collectionView).firstMatch
        XCTAssert(collectionView.exists)
        
    }
    func testTagItemsCellExists () {
        app.launch()
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.firstMatch
        firstCell.isAccessibilityElement = true
        let collectionView = firstCell.descendants(matching: .collectionView).firstMatch
        collectionView.tap()
        
        let secondCell = tableView.cells.element(boundBy: 1)
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: secondCell) { () -> Bool in
            XCTAssert(secondCell.exists)
            secondCell.tap()
            return true
        }
        waitForExpectations(timeout: 10, handler: nil)

    }
    
    
    func testPullRefresh() {
        app.launch()
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 5))
        start.press(forDuration: 0, thenDragTo: finish)
        XCTAssert(tableView.cells.count == 1)
        
    }
    
}
