//
//  XibNewsTableViewCell.swift
//  VK
//
//  Created by Semen Vinnikov on 16.07.2022.
//

import UIKit

class XibNewsTableViewCell: UITableViewCell {

    
    @IBOutlet var iconUserNews: UIImageView!
    @IBOutlet var nameUserNews: UILabel!
    @IBOutlet var dateUserNews: UILabel!
    @IBOutlet var textNews: UILabel!
    @IBOutlet var imageNews: UIImageView!
    @IBOutlet var viewNews: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconUserNews.layer.cornerRadius = iconUserNews.bounds.width / 2
        imageNews.layer.cornerRadius = imageNews.bounds.width / 20
        
        iconUserNews.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        recognizer.numberOfTapsRequired = 1
        iconUserNews.addGestureRecognizer(recognizer)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    // Анимация при тапе на аватарку
    @objc func onTap(gestureRecognizer: UIGestureRecognizer) {
        let original = self.iconUserNews.transform
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.1, options: [.autoreverse], animations: {
            self.iconUserNews.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: {_ in
            self.iconUserNews.transform = original
        })
    }
    
}
