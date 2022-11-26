//
//  AddGroupCell.swift
//  VK
//
//  Created by Semen Vinnikov on 30.06.2022.
//

import UIKit

class AddGroupCell: UITableViewCell {

    @IBOutlet var iconAddGroupCell: UIImageView!
    @IBOutlet var nameAddGroupCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconAddGroupCell.layer.cornerRadius = iconAddGroupCell.bounds.height / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
