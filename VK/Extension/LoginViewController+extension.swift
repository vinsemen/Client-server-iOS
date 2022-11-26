//
//  LoginViewController+extension.swift
//  VK
//
//  Created by Semen Vinnikov on 22.06.2022.
//

import Foundation
import UIKit


extension LoginViewController {
    
    func show(message: String) {
        
        let alertVC = UIAlertController(title: "Ошибка",
                                        message: message,
                                        preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Понятно",
                                     style: .default) { _ in
            self.loginTextField.text = ""
            self.passwordTextField.text = ""
        }
        
        alertVC.addAction(okAction)
        present(alertVC, animated: true)
    }
}
