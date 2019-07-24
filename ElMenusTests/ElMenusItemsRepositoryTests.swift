//
//  ElMenusItemsRepositoryTests.swift
//  ElMenusTests
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
import RxSwift
@testable import ElMenus

class ElMenusItemsRepositoryTests: XCTestCase {

    var sut: ItemsRepository!
    let disposeBag = DisposeBag()
    override func setUp() {
        sut = ItemsRepository()
    }

    override func tearDown() {
        sut = nil
    }

    func testRepositoryRequestListners()
    {

        let expectation = XCTestExpectation.init(description: "get rmote data")
        var responseResult: ItemsResponseModel!
        sut.objObservableRemoteData.subscribe({ (subObj) in

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
        sut.getItemsList(tagName: "Dessert")
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(responseResult)
    }

    func testRepositoryLocalListners()
    {

        let expectation = XCTestExpectation.init(description: "get local data")
        var responseResult: ItemsResponseModel!
        sut.objObservableLocal.subscribe({ (subObj) in

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
        sut.getItemsList(tagName: "Dessert")
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(responseResult)
    }

    // please make sure that no internet connection so that test passes
    func testRepositoryErrorListners()
    {

        let expectation = XCTestExpectation.init(description: "get error from repo")
        var errorResult: Error!
        sut.objObservableErrorModel.subscribe({ (subObj) in

            switch subObj
            {
            case .next(let error):
                errorResult = error
                expectation.fulfill()
            case .error(_):
                expectation.fulfill()
            case .completed:
                print("Completed")
            }

        }).disposed(by: disposeBag)
        sut.getItemsList(tagName: "Dessert")
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(errorResult)
    }

}
