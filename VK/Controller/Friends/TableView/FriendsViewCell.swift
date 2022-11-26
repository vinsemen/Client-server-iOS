//
//  FriendsViewCell.swift
//  VK
//
//  Created by Semen Vinnikov on 27.06.2022.
//

import UIKit

class FriendsViewCell: UITableViewCell {

    @IBOutlet var iconFriendsCell: UIImageView!
    @IBOutlet var nameFriendsCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //iconFriendsCell.layer.cornerRadius = iconFriendsCell.bounds.height / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
