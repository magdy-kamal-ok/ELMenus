//
//  ItemsResponseModel.swift
//  ElMenus
//
//  Created by mac on 7/20/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class ItemsResponseModel: Object, Mappable {


    @objc dynamic var tagName: String = ""
    var items: List<ItemModel> = List<ItemModel>()


    required convenience public init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        items <- (map["items"], ListTransform<ItemModel>())
    }

    override class func primaryKey() -> String? {
        return "tagName";
    }


}
