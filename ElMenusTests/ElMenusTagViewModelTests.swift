//
//  ElMenusTagViewModelTests.swift
//  ElMenusTests
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
import RxSwift
@testable import ElMenus

class ElMenusTagViewModelTests: XCTestCase {

    var sut: TagsViewModel!
    let disposeBag = DisposeBag()
    override func setUp() {
        sut = TagsViewModel()
    }

    override func tearDown() {
        sut = nil
    }

    func testgetListOfTags()
    {

        let expectation = XCTestExpectation.init(description: "get tags")
        var responseResult: [TagModel]!
        sut.observableTagList.subscribe({ (subObj) in

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
        sut.getTagsList()
        wait(for: [expectation], timeout: 10)
        XCTAssert(responseResult.count > 0)
    }

    func testLoadMoreTags()
    {

        let expectation = XCTestExpectation.init(description: "get more tags")
        var responseResult: [TagModel]!
        sut.observableTagList.subscribe({ (subObj) in

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
        sut.loadMoreTags()
        wait(for: [expectation], timeout: 10)
        XCTAssert(responseResult.count > 0)
    }

}
