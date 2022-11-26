//
//  AvatarView.swift
//  VK
//
//  Created by Semen Vinnikov on 09.07.2022.
//

import UIKit

class AvatarView: UIView {

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var shadowView: UIView!
    
    var shadowColor = UIColor.black
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowRadius = 5
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowOpacity = 0.9
        
    }
    
    override func layoutSubviews() {
        avatarImageView.layer.cornerRadius = bounds.width / 2
        shadowView.layer.cornerRadius = bounds.width / 2
    }
    
}
