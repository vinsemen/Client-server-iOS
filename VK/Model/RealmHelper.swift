//
//  RealmHelper.swift
//  VK
//
//  Created by Семён Винников on 15.12.2022.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    //MARK: получение объекта realm
    static func getRealm() -> Realm? {
        
        var realm: Realm?
        do {
            realm = try Realm()
        } catch {
            print(error)
        }
        return realm

    }

    //MARK: сохранение объекта VkUsers в realm
    static func saveUsersToRealm(arr: [VkUsers]) {
        
        guard let realm = RealmHelper.getRealm() else { return }
        
        //print(realm.configuration.fileURL)
        do {
            let oldUsers = realm.objects(VkUsers.self)
            realm.beginWrite()
            realm.delete(oldUsers)
            try realm.commitWrite()
            
        } catch {
            // если произошла ошибка, выводим ее в консоль
            print(error)
        }
        
        try! realm.write({
            realm.add(arr)
        })
    }

    //MARK: сохранение объекта VkPhoto в realm
    static func saveUsersPhotosToRealm(arr: [VkPhoto], user_id: Int) {
        guard let realm = RealmHelper.getRealm() else { return }
        
        do {
            let oldPhotos = realm.objects(VkPhoto.self)//.where {
            //    $0.owner_id == user_id
            //}
            realm.beginWrite()
            realm.delete(oldPhotos)
            try realm.commitWrite()
            
        } catch {
            // если произошла ошибка, выводим ее в консоль
            print(error)
        }
        
        try! realm.write({
            realm.add(arr)
        })
    }

    //MARK: сохранение объекта VkGroup в realm
    static func saveGroupsToRealm(arr: [VkGroup]) {
        guard let realm = RealmHelper.getRealm() else { return }
        
        do {
            let oldGroups = realm.objects(VkGroup.self)
            realm.beginWrite()
            realm.delete(oldGroups)
            try realm.commitWrite()
            
        } catch {
            // если произошла ошибка, выводим ее в консоль
            print(error)
        }
        
        try! realm.write({
            realm.add(arr)
        })
    }

    
}
