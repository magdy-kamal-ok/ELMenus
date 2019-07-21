//
//  ItemsTagViewModel.swift
//  ElMenus
//
//  Created by mac on 7/21/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RxSwift
import Reachability

class ItemsTagViewModel: BaseNetworkConnectionViewModel {
    
    let disposeBag = DisposeBag()
    let itemsRepo = ItemsRepository()
    public var tagName:String = ""
    private var subjectTagItem = PublishSubject<ItemsResponseModel?>()
    
    public var observableTagItem:Observable<ItemsResponseModel?>{
        return subjectTagItem.asObservable()
    }
    
    override init() {
        super.init()
        initializeSubscribers()
    }
    
    private func initializeSubscribers()
    {
        itemsRepo.objObservableLocal.subscribe(onNext: { (itemsResponseModel) in
            if !self.isNetworkConnected()
            {
                self.handleLoadedTagItemsResponse(itemsTagModel: itemsResponseModel)
            }
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
        itemsRepo.objObservableRemoteData.subscribe(onNext: { (itemsResponseModel) in
            self.handleLoadedTagItemsResponse(itemsTagModel: itemsResponseModel)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
        itemsRepo.objObservableErrorModel.subscribe(onNext: { (errorModel) in
            self.hideProgressLoaderIndicator()
            UIHelper.showInfoMessage(errorModel.desc, title: "ElMenus")
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
    }
    
    func handleLoadedTagItemsResponse(itemsTagModel:ItemsResponseModel)
    {

        self.subjectTagItem.onNext(itemsTagModel)
        self.hideProgressLoaderIndicator()
    }
    
    
    func getTagsList(tagName:String)
    {
        self.tagName = tagName
        self.showProgressLoaderIndicator()
        self.itemsRepo.getItemsList(tagName: self.tagName)
    }
    

    func refreshTagItemsList()
    {
        self.subjectTagItem.onNext(nil)
    }
    override func handleInternetConnectionReconnected() {
        self.refreshTagItemsList()
    }
    override func handleInternetConnectionDisconnected() {
        
    }
    
}
