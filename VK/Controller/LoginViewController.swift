//
//  ViewController.swift
//  VK
//
//  Created by Semen Vinnikov on 15.06.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Singletone
    let session = Session.shared
    let service = Service.shared
    
    
    //MARK: - Properties
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    // loading view
    @IBOutlet var loadingView: UIView!
    // loading images
    @IBOutlet var leftLoadingImage: UIImageView!
    @IBOutlet var centerLoadingImage: UIImageView!
    @IBOutlet var rightLoadingImage: UIImageView!
    
 
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        passwordTextField.isSecureTextEntry = true
        
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        // Скругление у кнопки "Войти"
        returnButton.layer.cornerRadius = 10
        
        // Скрытие вью с индикацией загрузки
        loadingView.isHidden = true
        
    }
    
    
//MARK: - Нажатие на кнопку
    @IBAction func loginButtonPress(_ sender: Any) {
        
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              login == "",
              password == "" else {
            show(message: "Неверные логин или пароль")
            return }
        
        // Отображение вью с индикацией загрузки
        loadingView.isHidden = false
        
        // Начало анимации по нажатию на кнопку
        setupLoginAnimationView()
        
        // Таймер для загрузки анимации (3 сек)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            // переход через сегу в сториборде
            self.performSegue(withIdentifier: "Login", sender: nil)
            
            // переход в коде через StoryboardID
            // почему-то неправильно отображается - слишком низко уезжает контроллер
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let mainNavigationController = storyboard.instantiateViewController(identifier: "MainNavigationController")
//
//            mainNavigationController.transitioningDelegate = self
//            self.present(mainNavigationController, animated: true)
            
            // Скрытие вью с индикацией загрузки
            self.loadingView.isHidden = true
        }
   
    }
    
    
//MARK: - Функция анимации точек
    
    func setupLoginAnimationView() {
        
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.repeat, .autoreverse], animations: { self.leftLoadingImage.alpha = 0 })
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: [.repeat, .autoreverse], animations: { self.centerLoadingImage.alpha = 0 })
        
        UIView.animate(withDuration: 0.6, delay: 0.4, options: [.repeat, .autoreverse], animations: { self.rightLoadingImage.alpha = 0 })
    }
    
    
//MARK: - Клавиатура
    
    @IBOutlet var returnButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!

    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Метод отписки при исчезновении контроллера с экрана
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Исчезновение клавиатуры при клике по пустому месту
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
}



extension LoginViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TopDownAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TopDownAnimation()
    }
    
}
