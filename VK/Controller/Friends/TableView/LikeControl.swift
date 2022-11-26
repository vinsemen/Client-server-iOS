//
//  LikeControl.swift
//  VK
//
//  Created by Semen Vinnikov on 09.07.2022.
//

import UIKit

class LikeControl: UIControl {

    @IBOutlet var likeIcon: UIImageView!
    @IBOutlet var likeCount: UILabel!

    
    override func awakeFromNib() {
        setupLikeControl()
    }
    
    
    
    var countLikes = 0
    var isLike: Bool = false
    var colorNoLike: UIColor = UIColor.white {
        didSet {
            likeIcon.tintColor = colorNoLike
            likeCount.tintColor = colorNoLike
        }
    }
    var colorYesLike: UIColor = UIColor.red
    
    
    // Настройка отображения сердечка и счетчика
    func setupLikeControl() {
        
        likeIcon.backgroundColor = .clear
        likeIcon.image = UIImage(systemName: "heart")
        likeIcon.tintColor = colorNoLike
        
        likeCount.text = String(countLikes)
        likeCount.font = .systemFont(ofSize: 27)
        likeCount.textColor = colorNoLike
    }

    // Момент первого нажатия
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {

        // Анимация сердечка
        let original = self.likeIcon.transform
        UIView.animate(withDuration: 0.1, delay: 0, options: [.autoreverse], animations: {
            self.likeIcon.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: {_ in
            self.likeIcon.transform = original
        })
        
        // Анимация счетчика
        UIView.transition(with: likeCount, duration: 0.2, options: [.transitionFlipFromBottom]) {
            self.likeCount.text = String(self.countLikes)
        } completion: { _ in

        }
        
        
        if isLike {
            isLike = false
            countLikes -= 1
            likeCount.text = String(countLikes)
            likeIcon.tintColor = colorNoLike
            likeCount.textColor = colorNoLike
            likeIcon.image = UIImage(systemName: "heart")
        } else {
            isLike = true
            countLikes += 1
            likeCount.text = String(countLikes)
            likeIcon.tintColor = colorYesLike
            likeCount.textColor = colorYesLike
            likeIcon.image = UIImage(systemName: "heart.fill")
        }
        
        return false
    }
    
}
