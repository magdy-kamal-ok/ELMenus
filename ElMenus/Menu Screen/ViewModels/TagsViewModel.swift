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

class TagsViewModel: NSObject {

    let disposeBag = DisposeBag()
    let tagsRepo = TagsRepository()
    public var tagIndex:Int = 1
    private var tagsList = [TagModel]()
    
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
            print(tagsResponseModel)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
        tagsRepo.objObservableRemoteData.subscribe(onNext: { (tagsResponseModel) in
            self.tagsList.append(contentsOf: tagsResponseModel.tags.toArray())
            self.subjectTagList.onNext(self.tagsList)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
        tagsRepo.objObservableErrorModel.subscribe(onNext: { (errorModel) in
            print(errorModel)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
    }
    
    func getTagsList()
    {
        self.tagsRepo.getTagsList(offset: self.tagIndex)
    }
}
