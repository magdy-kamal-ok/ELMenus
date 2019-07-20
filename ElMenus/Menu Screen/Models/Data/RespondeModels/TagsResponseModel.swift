//
//  TagsResponseModel.swift
//  ElMenus
//
//  Created by mac on 7/20/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class TagsResponseModel: Object,Mappable {
    
    
    @objc dynamic var offset:Int = 0
    var tags : List<TagModel> = List<TagModel>()
    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        tags      <- (map["tags"], ListTransform<TagModel>())
    }
    
    override class func primaryKey() -> String? {
        return "offset";
    }
    
    
}
