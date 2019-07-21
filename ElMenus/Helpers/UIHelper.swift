//
//  UIHelper.swift
//  ElMenus
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import SVProgressHUD
import TWMessageBarManager

class UIHelper {
    
    class func showInfoMessage(_ infoMessage: String?, title: String?) {
        if !TWMessageBarManager.sharedInstance().isMessageVisible {
            
            TWMessageBarManager.sharedInstance().showMessage(withTitle: title, description: infoMessage, type: .info, statusBarStyle: UIStatusBarStyle.lightContent, callback: nil)
        }
    }
    class func showSuccessMessage(_ message: String?, title: String?) {
        if !TWMessageBarManager.sharedInstance().isMessageVisible {
            TWMessageBarManager.sharedInstance().showMessage(withTitle: title, description: message, type: .success, statusBarStyle: UIStatusBarStyle.lightContent, callback: nil)
        }
    }
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



