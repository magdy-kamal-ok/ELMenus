//
//  extendedRepo.swift
//  ElMenus
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm


// user model base use for this module
class AttendeeProfileModel: Object,Mappable {
    required convenience public init?(map: Map) {
        self.init()
    }
    @objc dynamic var id:Int = 0;
    @objc dynamic var name:String = "";

    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    
    
    func mapping(map: Map) {
        id          <- map["id"]
        name          <- map["name"]

    }
}

class ExtendedRepo: GenericBaseRepository<AttendeeProfileModel, AttendeeProfileModel> {
    
    override func getPredicate() -> NSPredicate? {
        let id  = 1
        
        let predicate = NSPredicate.init(format: "id=%i", id)
        print(predicate)
        return predicate
    }

}
