//
//  SwiftTypeExtensions.swift
//  ElMenus
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

// MARK: - extension to provide default value to optional string
extension Optional where Wrapped == String {
    func defaultValueIfNotExists()->String{
        return self != nil ? self! : ""
    }
}

// MARK: - extention to convert struct to json dictionary to send to api
extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var data: Data {
        return try! JSONEncoder().encode(self)
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] ?? [:]
    }
}
