//
//  GenericDao.swift
//  ElMenus
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class GenericDao<R:Object>: GenericDataLocalSource{
    
    func insert(genericDataModel : R) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(genericDataModel,update:true)
            try realm.commitWrite()
        } catch (let error) {
            print(error)
        }
    }

    
    func fetch(predicate:NSPredicate?)->R? {
        do {
            let realm = try  Realm()
            if let predicate = predicate
            {
                return realm.objects(R.self).filter(predicate).first
            }
            else
            {
               return realm.objects(R.self).first
            }
        } catch (let error) {
            print(error)
            return nil
        }
    }
    
    
    func delete(){
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.delete(realm.objects(R.self))
            try realm.commitWrite()
        } catch (let error) {
            print(error)
        }
    }
}
