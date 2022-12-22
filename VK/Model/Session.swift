//
//  Session.swift
//  VK
//
//  Created by Семён Винников on 27.11.2022.
//

import Foundation


class Session {
    static let shared = Session()
    
    private init(){}
    
    var token = ""
    var userID = 0
    
    var friendsIds: [Int] = []
    var friends : [VkUsers] = []
}
