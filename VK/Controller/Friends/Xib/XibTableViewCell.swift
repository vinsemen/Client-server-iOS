//
//  XibTableViewCell.swift
//  VK
//
//  Created by Semen Vinnikov on 14.07.2022.
//

import UIKit

class XibTableViewCell: UITableViewCell {

    @IBOutlet var imageFriend: UIImageView!
    @IBOutlet var nameFriend: UILabel!
    @IBOutlet var animatableImageFriendView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Скругление у иконки друга
        imageFriend.layer.cornerRadius = imageFriend.bounds.height / 2
        // Разрешение использовать нажатия на вью
        animatableImageFriendView.isUserInteractionEnabled = true

        // Обработка тапа на аватарку
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        // Количество нажатий на аватарку
        recognizer.numberOfTapsRequired = 1
        // Добавить наблюдение
        animatableImageFriendView.addGestureRecognizer(recognizer)
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // Анимация при тапе на аватарку
    @objc func onTap(gestureRecognizer: UITapGestureRecognizer) {
        // Сохранение состояния вью
        let original = self.animatableImageFriendView.transform
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.1, options: [.autoreverse], animations: {
            // Меняем размер вью
            self.animatableImageFriendView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: {_ in
            // Возвращаем вью в исходное положение
            self.animatableImageFriendView.transform = original
        })
    }
    
    
//    @IBAction func avatarPressed() {
//        tapOnView()
//    }
    
//    // Обработка тапа на аватарку
//    func tapOnView() {
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
//        // количество нажатий на аватарку
//        recognizer.numberOfTapsRequired = 1
//        // Добавить наблюдение
//        self.addGestureRecognizer(recognizer)
//    }
//

}

