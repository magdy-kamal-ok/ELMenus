//
//  Constants.swift
//  ElMenus
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

class Constants {
    
    private static let baseUrl = "https://elmenus-assignment.getsandbox.com/"
    public static let  tagesApiUrl = Constants.baseUrl + "tags/"
    public static let itemsApiUrl = Constants.baseUrl + "items/"
    
    public static let imagePlaceHolderName = "ic_image_iphone_placeholder"
    public static let backButtonImage = "ic_back_arrow"
    public static let basicColor = "BasicColor"
    
    public static let appName = "appName"
    public static let internertConnectionDisconnected = "internertConnectionDisconnected"
    public static let tagSectionTitle = "tagSectionTitle"
    public static let internertConnectionReconnected = "internertConnectionReconnected"
    public static let menuScreenTitle = "menuScreenTitle"
    

    // access identifiers
    public static let tableViewIdentifier = "menuListTableView"
    public static let backButtonIdentifier = "backButton"
    public static let scrollViewItemDetailsIdentifier = "scrollView"

}
