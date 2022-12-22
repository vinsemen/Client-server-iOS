//
//  Utilities.swift
//  VK
//
//  Created by Семён Винников on 19.12.2022.
//

import Foundation
import UIKit


@available(iOS 15, *)
class Utilities {
    
    func StringToDate(_ dateStr: String) -> Date {
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return RFC3339DateFormatter.date(from: dateStr) ?? Date.now
    }
    
    func UrlToImage(url: String?, complection: @escaping (UIImage) -> ()) {
        
        guard let url = url else { return }
        
        // Create Data Task
        let dataTask = URLSession.shared.dataTask(with: URL(string: url)!) { (data, _, _) in
            
            if let data = data {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
                    complection(UIImage(data: data)!)
                }
            }
        }
        
        // Start Data Task
        dataTask.resume()
    }
}
