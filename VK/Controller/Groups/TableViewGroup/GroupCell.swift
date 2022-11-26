//
//  GroupCell.swift
//  VK
//
//  Created by Semen Vinnikov on 30.06.2022.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet var iconGroupCell: UIImageView!
    @IBOutlet var nameGroupCell: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconGroupCell.layer.cornerRadius = iconGroupCell.bounds.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
