//
//  ElMenusGenericDaoTests.swift
//  ElMenusTests
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
import RealmSwift
@testable import ElMenus

class ElMenusGenericDaoTests: XCTestCase {

    var testRealm: Realm!

    override func setUp() {

        do {

            var realmConfiguration = Realm.Configuration.init()
            realmConfiguration.inMemoryIdentifier = "realmTest"
            testRealm = try Realm(configuration: realmConfiguration)

        } catch (let error) {
            fatalError(error.localizedDescription)
        }
    }

    override func tearDown() {
        testRealm = nil
    }

    func testInsertAndFetchTagsResponseModel()
    {
        let sut = GenericDao<TagsResponseModel>.init(realm: testRealm)
        let tagResponseModel = TagsResponseModel.init()
        tagResponseModel.offset = 40
        sut.insert(genericDataModel: tagResponseModel)
        let predicate = NSPredicate.init(format: "offset=%i", 40)
        let savedTagResponseModel = sut.fetch(predicate: predicate)
        XCTAssertEqual(savedTagResponseModel?.offset, 40)
    }
    func testInsertAndFetchTagModel()
    {
        let sut = GenericDao<TagModel>.init(realm: testRealm)
        let tagModel = TagModel.init()
        tagModel.tagName = "my tag"
        tagModel.photoUrl = "https://www.myphoto.com/myphoto"
        sut.insert(genericDataModel: tagModel)
        let predicate = NSPredicate.init(format: "tagName=%@", "my tag")
        let savedTagModel = sut.fetch(predicate: predicate)
        XCTAssertEqual(savedTagModel?.tagName, "my tag")
        XCTAssertEqual(savedTagModel?.photoUrl, "https://www.myphoto.com/myphoto")
    }

    func testInsertAndFetchTagItemsResponseModel()
    {
        let sut = GenericDao<ItemsResponseModel>.init(realm: testRealm)
        let itemsResponseModel = ItemsResponseModel.init()
        itemsResponseModel.tagName = "my tag"
        sut.insert(genericDataModel: itemsResponseModel)
        let predicate = NSPredicate.init(format: "tagName=%@", "my tag")
        let savedItemsResponseModel = sut.fetch(predicate: predicate)
        XCTAssertEqual(savedItemsResponseModel?.tagName, "my tag")
    }

    func testInsertAndFetchItemModel()
    {
        let sut = GenericDao<ItemModel>.init(realm: testRealm)
        let itemModel = ItemModel.init()
        itemModel.id = 5555
        itemModel.name = "my item"
        itemModel.photoUrl = "https://www.myphoto.com/myphoto"
        itemModel.desc = "hello this my item model"
        sut.insert(genericDataModel: itemModel)
        let predicate = NSPredicate.init(format: "id=%i", 5555)
        let savedItemModel = sut.fetch(predicate: predicate)
        XCTAssertEqual(savedItemModel?.id, 5555)
        XCTAssertEqual(savedItemModel?.name, "my item")
        XCTAssertEqual(savedItemModel?.photoUrl, "https://www.myphoto.com/myphoto")
        XCTAssertEqual(savedItemModel?.desc, "hello this my item model")
    }
}
