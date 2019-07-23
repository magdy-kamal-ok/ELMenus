//
//  ItemModel.swift
//  ElMenus
//
//  Created by mac on 7/20/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class ItemModel: Object,Mappable {
    
    @objc dynamic var id:Int = 0
    @objc dynamic var name:String = ""
    @objc dynamic var photoUrl:String = ""
    @objc dynamic var desc: String = ""
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        photoUrl            <- map["photoUrl"]
        desc                <- map["description"]
    }
    
    override class func primaryKey() -> String? {
        return "id";
    }
}
