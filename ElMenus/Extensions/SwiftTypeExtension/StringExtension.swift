//
//  StringExtension.swift
//  ElMenus
//
//  Created by mac on 7/22/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
