//
//  TagModel.swift
//  ElMenus
//
//  Created by mac on 7/20/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class TagModel: Object, Mappable {

    @objc dynamic var tagName: String = ""
    @objc dynamic var photoUrl: String = ""

    required convenience public init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {

        tagName <- map["tagName"]
        photoUrl <- map["photoURL"]

    }
    override class func primaryKey() -> String? {
        return "tagName";
    }
}
