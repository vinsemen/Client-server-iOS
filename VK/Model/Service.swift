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
    
    let session = Session.shared
    
    //получение списка друзей
    func getFriends(completion: @escaping (Response) -> ()) {
        let url = baseURL + "/friends.get"
        
        let parameters: Parameters = [
            "access_token": session.token,
            "v": "5.131",
            "count" : 50,
            "fields": "photo_100"
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { responce in
            if let data = responce.value {
                let friend = try! JSONDecoder().decode(Response.self, from: data)
                completion(friend)
            }
        }
    }
    
    // получение фото пользователя
    func getImageUser(completion: @escaping (ResponsePhotos) -> ()){
        let url = baseURL + "/photos.get"
        
        let parameters: Parameters = [
            "access_token": session.token,
            "owner_id": 675405507,//-51396340,
            "album_id": "profile",
            "v": "5.131",
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { responce in
            if let data = responce.value {
                let friendPhotos = try! JSONDecoder().decode(ResponsePhotosFriend.self, from: data)
                completion(friendPhotos.response)
            }
            
            //print("photos is \(responce)")
            
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
