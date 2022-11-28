//
//  Service.swift
//  VK
//
//  Created by Семён Винников on 28.11.2022.
//

import Foundation
import Alamofire

class Service {
    
    let baseURL = "https://api.vk.com/method"
    
    //получение списка друзей
    func getFriends(token: String) {
        let url = baseURL + "/friends.get"
        
        let parameters: Parameters = [
            "access_token": token,
            "v": "5.131",
            "count" : 50,
            "fields": "city,country"
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { responce in
            print("my friends is \(responce)")
        }
    }
    
    // получение фото пользователя
    func getImageUser(token: String){
        let url = baseURL + "/photos.get"
        
        let parameters: Parameters = [
            "access_token": token,
            "owner_id": -51396340,
            "album_id": "profile",
            "v": "5.131",
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { responce in
            print("photos is \(responce)")
        }
    }
    
    
    // получение групп пользователя
    func getGroupUser(token: String){
        let url = baseURL + "/groups.get"
        
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
