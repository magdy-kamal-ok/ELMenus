//
//  ElMenusGenericRequestTests.swift
//  ElMenusGenericRequestTests
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
import RxSwift
import Alamofire
@testable import ElMenus

class ElMenusGenericRequestTests: XCTestCase {

    let disposeBag = DisposeBag()

    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    func testSuccessTagsRequestClass()
    {
        let sut = GenericRequestClass<TagsResponseModel>()
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            ]
        let offset = 1
        let expectation = XCTestExpectation.init(description: "Make request Call")
        var responseResult: TagsResponseModel!
        var errorResponse:Error!
        sut.callApi(url: Constants.tagesApiUrl + "\(offset)" , params: nil, headers: headers)?.subscribe({ (subObj) in
            
            switch subObj
            {
            case .next(let responseObj):
                responseResult = responseObj
                expectation.fulfill()
            case .error(let error):
                errorResponse = error
                expectation.fulfill()
            case .completed:
                print("Completed")
            }
            
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(responseResult)
        XCTAssertNil(errorResponse)
    }
    
    func testFailureTagsRequestClass()
    {
        let sut = GenericRequestClass<TagsResponseModel>()
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            ]
        let offset = 1
        let expectation = XCTestExpectation.init(description: "Make request Call")
        var responseResult: TagsResponseModel!
        var errorResponse:Error!
        let url = "https://elmenus-assignment.getsandboxs.com/tags/\(offset)"
        sut.callApi(url: url , params: nil, headers: headers)?.subscribe({ (subObj) in
            
            switch subObj
            {
            case .next(let responseObj):
                responseResult = responseObj
                expectation.fulfill()
            case .error(let error):
                errorResponse = error
                expectation.fulfill()
            case .completed:
                print("Completed")
            }
            
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 10)
        XCTAssertNil(responseResult)
        XCTAssertNotNil(errorResponse)
    }

    func testSuccessItemsTagRequestClass()
    {
        let sut = GenericRequestClass<ItemsResponseModel>()
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            ]
        let tagName = "Dessert"
        let expectation = XCTestExpectation.init(description: "Make request Call")
        var responseResult: ItemsResponseModel!
        var errorResponse:Error!
        sut.callApi(url: Constants.itemsApiUrl + "\(tagName)" , params: nil, headers: headers)?.subscribe({ (subObj) in
            
            switch subObj
            {
            case .next(let responseObj):
                responseResult = responseObj
                expectation.fulfill()
            case .error(let error):
                errorResponse = error
                expectation.fulfill()
            case .completed:
                print("Completed")
            }
            
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(responseResult)
        XCTAssertNil(errorResponse)
    }
    
    func testFailureItemsTagRequestClass()
    {
        let sut = GenericRequestClass<ItemsResponseModel>()
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            ]
        let tagName = "Dessert"
        let expectation = XCTestExpectation.init(description: "Make request Call")
        var responseResult: ItemsResponseModel!
        var errorResponse:Error!
        let url = "https://elmenus-assignment.getsandboxs.com/items/\(tagName)"
        sut.callApi(url: url , params: nil, headers: headers)?.subscribe({ (subObj) in
            
            switch subObj
            {
            case .next(let responseObj):
                responseResult = responseObj
                expectation.fulfill()
            case .error(let error):
                errorResponse = error
                expectation.fulfill()
            case .completed:
                print("Completed")
            }
            
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 10)
        XCTAssertNil(responseResult)
        XCTAssertNotNil(errorResponse)
    }
}
