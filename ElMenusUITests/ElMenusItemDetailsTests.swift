//
//  ElMenusItemDetailsTests.swift
//  ElMenusUITests
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
@testable import ElMenus

class ElMenusItemDetailsTests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    
    func testTagItemsDetailsBackButtonExists () {
        app.launch()
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.firstMatch
        firstCell.isAccessibilityElement = true
        let collectionView = firstCell.descendants(matching: .collectionView).firstMatch
        collectionView.tap()
        let secondCell = tableView.cells.element(boundBy: 1)
        secondCell.isAccessibilityElement = true
        secondCell.tap()
        let backButton = self.app.buttons[Constants.backButtonIdentifier]
        XCTAssert(backButton.exists)
        
    }
    
    func testTagItemsDetailsScrollViewExists() {
        app.launch()
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.firstMatch
        firstCell.isAccessibilityElement = true
        let collectionView = firstCell.descendants(matching: .collectionView).firstMatch
        collectionView.tap()
        let secondCell = tableView.cells.element(boundBy: 1)
        secondCell.isAccessibilityElement = true
        secondCell.tap()
        let scrollView = app.scrollViews[Constants.scrollViewItemDetailsIdentifier]
        XCTAssert(scrollView.exists)
        
    }
    func testTagItemsDetailsScrollViewAnimationExists() {
        app.launch()
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.firstMatch
        firstCell.isAccessibilityElement = true
        let collectionView = firstCell.descendants(matching: .collectionView).firstMatch
        collectionView.tap()
        let secondCell = tableView.cells.element(boundBy: 13)
        secondCell.isAccessibilityElement = true
        secondCell.tap()
        let scrollView = app.scrollViews[Constants.scrollViewItemDetailsIdentifier]
        scrollView.swipeUp()
        scrollView.swipeUp()

        
    }
 
    func testTagItemsDetailsBackAction() {
        app.launch()
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.firstMatch
        firstCell.isAccessibilityElement = true
        let collectionView = firstCell.descendants(matching: .collectionView).firstMatch
        collectionView.tap()
        let secondCell = tableView.cells.element(boundBy: 13)
        secondCell.isAccessibilityElement = true
        secondCell.tap()
        let scrollView = app.scrollViews[Constants.scrollViewItemDetailsIdentifier]
        scrollView.swipeUp()
        let navBar = self.app.navigationBars.firstMatch
        navBar.buttons.firstMatch.tap()
        
    }
    
}
