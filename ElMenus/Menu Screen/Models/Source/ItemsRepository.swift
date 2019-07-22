//
//  ItemsRepository.swift
//  ElMenus
//
//  Created by mac on 7/20/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import Alamofire

class ItemsRepository: GenericBaseRepository<ItemsResponseModel, ItemsResponseModel> {
    
    var tagName = ""
    
    
    override func getPredicate() -> NSPredicate? {
        let predicate = NSPredicate.init(format: "tagName=%@", self.tagName)
        return predicate
    }
    
    func getItemsList(tagName:String)
    {
        self.tagName = tagName
        var url = Constants.itemsApiUrl + "\(self.tagName)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        self.getGenericData(url: url, data: nil, headers: self.getHeaders())
    }
    
    override func insertDataToLocal(genericDataModel: ItemsResponseModel) {
        genericDataModel.tagName = self.tagName
        super.insertDataToLocal(genericDataModel: genericDataModel)
        
    }
    
    private func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            ]
        return headers
    }
}
