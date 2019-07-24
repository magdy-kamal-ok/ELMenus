//
//  ElMenusItemsViewModelTests.swift
//  ElMenusTests
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
import RxSwift
@testable import ElMenus

class ElMenusItemsViewModelTests: XCTestCase {

    var sut: ItemsTagViewModel!
    let disposeBag = DisposeBag()
    override func setUp() {
        sut = ItemsTagViewModel()
    }

    override func tearDown() {
        sut = nil
    }

    func testgetListOfTags()
    {

        let expectation = XCTestExpectation.init(description: "get Items tags")
        var responseResult: ItemsResponseModel!
        sut.observableTagItem.subscribe({ (subObj) in

            switch subObj
            {
            case .next(let responseObj):
                responseResult = responseObj
                expectation.fulfill()
            case .error(_):
                expectation.fulfill()
            case .completed:
                print("Completed")
            }

        }).disposed(by: disposeBag)
        sut.getTagsList(tagName: "Dessert")
        wait(for: [expectation], timeout: 10)
        XCTAssert(responseResult.tagName == "Dessert")
    }



}
