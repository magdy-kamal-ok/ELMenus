//
//  UIHelper.swift
//  ElMenus
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import SVProgressHUD

class UIHelper {

    class func showProgressBarWithDimView() {
        SVProgressHUD().defaultMaskType = .black
        SVProgressHUD().defaultAnimationType = .flat
        SVProgressHUD.setForegroundColor(UIColor(named:"BasicColor")!)
        SVProgressHUD.show()
    }
    class func dissmissProgressBar() {
        SVProgressHUD.dismiss()
    }

    
}



