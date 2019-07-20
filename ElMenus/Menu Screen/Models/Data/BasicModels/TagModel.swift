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

class TagModel: Object,Mappable {
    
    @objc dynamic var tagName:String = ""
    @objc dynamic var photoURL:String = ""
  
    required convenience public init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        tagName             <- map["tagName"]
        photoURL            <- map["photoURL"]

        
        
    }
}
