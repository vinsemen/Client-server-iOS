//
//  Service.swift
//  VK
//
//  Created by Семён Винников on 28.11.2022.
//

import Foundation
import Alamofire
import RealmSwift


struct DecodableType: Decodable { let url: String }

class Service {

    static let shared = Service()
    
    private init() {}

    static let clientId : String = "51396340"
    static let redirectUrl: String = "https://oauth.vk.com/blank.html"
    static let baseURL = "https://api.vk.com/method"
    
    let session = Session.shared

    //получение списка друзей
    func getFriends(token: String, id: Int, completion: @escaping ([Int]) -> ()) {
        
        let url = Service.baseURL + "/friends.get"

        let parameters: Parameters = [
            "access_token": token,
            "user_id": id,
            "client_id": Service.clientId,
            "v": "5.131",
            "count" : 50,
            "order": "name" // сортировка по имени
        ]

        AF.request(url, method: .get, parameters: parameters).responseData { responce in
            
            print("===========getFriends===========")
            
            if let data = responce.value {
                let friend = try? JSONDecoder().decode(VkFriendsGet.self, from: data)
                
                guard let items = friend?.response.items else { return }

                self.session.friendsIds = items
                completion(items)
            }
        }
    }
    
    
    func getUsers(token: String, ids: [Int], completion: @escaping ([VkUsers]) -> ()) {

        let idsStr = ids.map { String($0) }.joined(separator: ",")
        
        let parameters: Parameters = [
            "access_token" : token,
            "user_ids": idsStr,
            "fields": "bdate, domain, sex, city, country, photo_400_orig, status, counters",
            "v": "5.131"
        ]

        let url = Service.baseURL + "/users.get"

        AF.request(url, method: .get, parameters: parameters).responseData { response in
            
            print("===========users.get===========")
 
            guard let data = response.value else { return }

            let users = try? JSONDecoder().decode(VkUsersGet.self, from: data)
            
            guard let items = users?.response else { return }
            
            self.session.friends = items
            
            completion(items)
        }
    }
 


    // получение фото пользователя
    func getImageUser(token: String, id: Int, completion: @escaping ()->()){
        let url = Service.baseURL + "/photos.get"

        let parameters: Parameters = [
            "access_token": token,
            "owner_id": id,
            "album_id": "profile",
            "extended": "likes",
            "photo_sizes": "0",
            "v": "5.131",
        ]

        AF.request(url, method: .get, parameters: parameters).responseData { responce in
            if let data = responce.value {
                let friendPhotos = try? JSONDecoder().decode(VkPhotosGet.self, from: data)
                guard let items = friendPhotos?.response.items else { return }
                RealmHelper.saveUsersPhotosToRealm(arr: items, user_id: id)
//                self.saveUsersPhotosToRealm(arr: items)
                completion()
            }

            //print("photos is \(responce)")
        }
    }


    // получение групп пользователя
    func getGroupUser(token: String){
        let url = Service.baseURL + "/groups.get"

        let parameters: Parameters = [
            "access_token": token,
            "user_id": 51396340,
            "v": "5.131",
        ]

        AF.request(url, method: .get, parameters: parameters).responseData { responce in
            print("my groups is \(responce)")
        }
    }

}
