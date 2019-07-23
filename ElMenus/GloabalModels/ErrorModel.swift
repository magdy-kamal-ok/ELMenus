//
//  ErrorModel.swift
//  ElMenus
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

struct ErrorModel : Error{

    
    let desc:String
    let code:Int
}
enum ErrorCodes:Int{
    case noCached = 2000
}


