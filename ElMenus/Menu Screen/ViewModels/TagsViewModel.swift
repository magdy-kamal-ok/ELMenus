//
//  TagsViewModel.swift
//  ElMenus
//
//  Created by mac on 7/20/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RxSwift
import Reachability

class TagsViewModel: BaseNetworkConnectionViewModel {

    let disposeBag = DisposeBag()
    let tagsRepo = TagsRepository()
    public var tagIndex:Int = 1
    private var tagsList = [TagModel]()
    private var isLoadingMore = false
    private var subjectTagList = PublishSubject<[TagModel]>()
    
    public var observableTagList:Observable<[TagModel]>{
        return subjectTagList.asObservable()
    }
    
    override init() {
        super.init()
        initializeSubscribers()
    }
    
    private func initializeSubscribers()
    {
        tagsRepo.objObservableLocal.subscribe(onNext: { (tagsResponseModel) in
            if !self.isNetworkConnected()
            {
                self.handleLoadedTags(tagsList: tagsResponseModel.tags.toArray())
            }
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
        tagsRepo.objObservableRemoteData.subscribe(onNext: { (tagsResponseModel) in
            self.handleLoadedTags(tagsList: tagsResponseModel.tags.toArray())
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
        tagsRepo.objObservableErrorModel.subscribe(onNext: { (errorModel) in
            self.hideProgressLoaderIndicator()
            UIHelper.showInfoMessage(errorModel.desc, title: "ElMenus")
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
    }
    
    func handleLoadedTags(tagsList: [TagModel])
    {
        if isLoadingMore
        {
            isLoadingMore = !isLoadingMore
        }
        self.tagsList.append(contentsOf: tagsList)
        self.subjectTagList.onNext(self.tagsList)
        self.hideProgressLoaderIndicator()
    }
    

    func getTagsList()
    {
        self.showProgressLoaderIndicator()
        self.tagsRepo.getTagsList(offset: self.tagIndex)
    }
    
    func loadMoreTags()
    {
        if !isLoadingMore
        {
            self.isLoadingMore = !self.isLoadingMore
            self.tagIndex += 1
            self.getTagsList()
        }
    }
    func resetDataSource()
    {
        self.tagsList.removeAll()
        self.tagIndex = 1
        
    }
    func refreshTagsList()
    {
        self.resetDataSource()
        self.getTagsList()
    }
    
    override func handleInternetConnectionReconnected() {
        UIHelper.showInfoMessage("Please be Informed Your internet Connection Reconnected", title: "ElMenus")
       self.refreshTagsList()
    }
    override func handleInternetConnectionDisconnected() {
        UIHelper.showInfoMessage("Please be Informed Your internet Connection Disconnected", title: "ElMenus")
        
    }

}
