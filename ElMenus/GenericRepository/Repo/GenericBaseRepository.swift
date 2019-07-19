//
//  GenericBaseRepository.swift
//  ElMenus
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import RealmSwift
import Alamofire


class GenericBaseRepository<REMOTE:Mappable,LOCAL:Object>:
GenericDataSourceContract {
    
    private let objGenericRequestClass:GenericRequestClass = GenericRequestClass<REMOTE>()
    private let objGenericDao:GenericDao = GenericDao<LOCAL>()
    
    private var objObservableDao = PublishSubject<LOCAL>()
    private var objObservableRemote = PublishSubject<REMOTE>()

    public var errorModule = PublishSubject<ErrorModel>()
    
    private var bag = DisposeBag()
    
    public var objObservableLocal:Observable<LOCAL>{
        return objObservableDao.asObservable()
    }
    
    public var objObservableRemoteData:Observable<REMOTE>{
        return objObservableRemote.asObservable()
    }

    
    
    func getGenericData(url:String, data:Parameters?, headers:HTTPHeaders?, bool:Bool = true)
    {
        if bool{
            if let cashedData = self.fetch(predicate: self.getPredicate())
            {
                
                objObservableDao.onNext(cashedData)

                self.callBackEndApi(url: url, params: data, headers: headers)
            }
            else{
                self.callBackEndApi(url: url, params: data, headers: headers)
            }

        }
        else
        {
            self.callBackEndApi(url: url, params: data, headers: headers)
        }
    }
    func callBackEndApi(url: String, params: Parameters?, headers: HTTPHeaders?)
    {
        self.callApi(url: url, params: params, headers: headers)?.subscribe({ (subObj) in
            
            switch subObj
            {
                case .next(let responseObj):
                    self.objObservableRemote.onNext(responseObj)
                    self.insert(genericDataModel: responseObj as! LOCAL)
                    //self.objObservableDao.onNext(responseObj as! LOCAL)
                case .error(_):
                    if let resultData = self.fetch(predicate: self.getPredicate())
                    {
                        //  _ =  self.repo1.fetch()
                        self.objObservableDao.onNext(resultData)
                    }
                    else{

                        self.errorModule.onNext(ErrorModel(desc: "network first time fail", code: 404))
                    }
                case .completed:
                    print("Completed")
            }
            
        }).disposed(by: bag)

    }
    

    func callApi(url: String, params: Parameters?, headers: HTTPHeaders?) -> Observable<REMOTE>? {
        if let objObserve = objGenericRequestClass.callApi(url: url,   params: params, headers: headers)
        {
            return objObserve
        }
        return Observable.empty()
    }
    
    func getPredicate()->NSPredicate?
    {
        //        preconditionFailure("You have to Override predicate To get Specified Data")
        return nil
    }
    
    func insertDataToLocal(genericDataModel : LOCAL) {
        // override this if needed 
        objGenericDao.insert(genericDataModel: genericDataModel)
    }
}
extension GenericBaseRepository{
    
    func fetch(predicate : NSPredicate?) -> LOCAL? {
        return objGenericDao.fetch(predicate: predicate)
    }
    
    
    func insert(genericDataModel : LOCAL) {
        self.insertDataToLocal(genericDataModel: genericDataModel)
    }

    
    func delete() {
        objGenericDao.delete()
    }
    
    
}

