//
//  Friends.swift
//  VK
//
//  Created by Semen Vinnikov on 27.06.2022.
//

import UIKit

class Friend {
    
    let name: String
    let icon: UIImage?
    
    init(name: String, icon: UIImage? = nil) {
        self.name = name
        self.icon = icon
    }
    
}
