//
//  UINavigationBarExtension.swift
//  ElMenus
//
//  Created by mac on 7/22/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

extension UINavigationBar
{
    func setAttributedTitle()
    {
        self.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]

    }

}
