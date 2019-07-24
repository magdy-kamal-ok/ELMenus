//
//  TagsRepository.swift
//  ElMenus
//
//  Created by mac on 7/20/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import Alamofire

class TagsRepository: GenericBaseRepository<TagsResponseModel, TagsResponseModel> {

    var offset = 0


    override func getPredicate() -> NSPredicate? {
        let predicate = NSPredicate.init(format: "offset=%i", self.offset)
        return predicate
    }

    func getTagsList(offset: Int)
    {
        self.offset = offset
        let url = Constants.tagesApiUrl + "\(self.offset)"
        self.getGenericData(url: url, data: nil, headers: self.getHeaders())
    }

    override func insertDataToLocal(genericDataModel: TagsResponseModel) {
        genericDataModel.offset = self.offset
        super.insertDataToLocal(genericDataModel: genericDataModel)

    }

    func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
        ]
        return headers
    }
}
