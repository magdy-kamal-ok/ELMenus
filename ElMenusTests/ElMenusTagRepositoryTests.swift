//
//  ElMenusTagRepositoryTests.swift
//  ElMenusTests
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
import RxSwift
@testable import ElMenus

class ElMenusTagRepositoryTests: XCTestCase {

    var sut: TagsRepository!
    let disposeBag = DisposeBag()
    override func setUp() {
        sut = TagsRepository()
    }

    override func tearDown() {
        sut = nil
    }

    func testRepositoryRequestListners()
    {

        let expectation = XCTestExpectation.init(description: "get remote data")
        var responseResult: TagsResponseModel!
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
        sut.getTagsList(offset: 1)
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(responseResult)
    }

    func testRepositoryLocalListners()
    {

        let expectation = XCTestExpectation.init(description: "get local data")
        var responseResult: TagsResponseModel!
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
        sut.getTagsList(offset: 1)
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(responseResult)
    }

    // please make sure that no internet connection so that test passes
    func testRepositoryErrorListners()
    {

        let expectation = XCTestExpectation.init(description: "get repo error")
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
        sut.getTagsList(offset: 1000)
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(errorResult)
    }

}
