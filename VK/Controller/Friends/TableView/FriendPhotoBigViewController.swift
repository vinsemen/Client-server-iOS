//
//  FriendPhotoBigViewController.swift
//  VK
//
//  Created by Semen Vinnikov on 26.07.2022.
//

import UIKit

class FriendPhotoBigViewController: UIViewController {

    // фото, которое стоит за основным - видно при переходе
    @IBOutlet var PhotoBigNext: UIImageView! {
        didSet {
            PhotoBigNext.isUserInteractionEnabled = true
        }
    }
    
    // основное фото
    @IBOutlet var PhotoBig: UIImageView! {
        didSet {
            PhotoBig.isUserInteractionEnabled = true
        }
    }
    
    enum AnimationDirection {
        case left
        case right
    }
    var animationDirection: AnimationDirection = .left
    
    
    var photos: [ImagesFriend] = []
    var selectedPhotoIndex: Int = 0
    
    var propertyAnimator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Фотографии"
        
        guard !photos.isEmpty else { return }
        PhotoBig.image = photos[selectedPhotoIndex].image
        
//        //***
//        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan))
//        view.addGestureRecognizer(recognizer)
//        //***
        
        // свайп влево
//        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeInLeft))
//        leftSwipe.direction = .left
//        PhotoBig.addGestureRecognizer(leftSwipe)
//
//        // свайп вправо
//        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeInRight))
//        rightSwipe.direction = .right
//        PhotoBig.addGestureRecognizer(rightSwipe)
//
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(viewPanned))
        view.addGestureRecognizer(panGR)
    }
    
    
    //MARK: - Обработка движения пальца
    @objc func viewPanned(_ panGestureRec: UIPanGestureRecognizer) {
        
        switch panGestureRec.state {
        case .began:
            if panGestureRec.translation(in: view).x > 0 {

                // направо
                
                guard selectedPhotoIndex >= 1 else { return }
            
                animationDirection = .right
                
                let newPhotoIndex = selectedPhotoIndex - 1
                let newPhoto = photos[newPhotoIndex].image
                
                PhotoBigNext.image = newPhoto
                PhotoBigNext.transform = CGAffineTransform(translationX: -PhotoBigNext.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                
                propertyAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut, animations: { [self] in
                    PhotoBig.transform = CGAffineTransform(translationX: PhotoBig.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
                    PhotoBigNext.transform = .identity
                })

                propertyAnimator.addCompletion { [self] position in
                    switch position {
                    case .end:
                        PhotoBig.image = newPhoto
                        PhotoBig.transform = .identity
                        selectedPhotoIndex = newPhotoIndex
                        //PhotoBigNext.image = nil
                    case .start:
                        PhotoBigNext.transform = CGAffineTransform(translationX: -PhotoBigNext.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
                    case .current:
                        break
                    @unknown default:
                        break
                    }
                }
                
            } else {
                
                //налево
                
                guard selectedPhotoIndex < photos.count - 1 else { return }
                animationDirection = .left
                
                let newPhotoIndex = selectedPhotoIndex + 1
                let newPhoto = photos[newPhotoIndex].image
                
                PhotoBigNext.image = newPhoto
                PhotoBigNext.transform = CGAffineTransform(translationX: 1.35 * PhotoBigNext.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
                
                propertyAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut, animations: { [self] in
                    PhotoBig.transform = CGAffineTransform(translationX: -1.35 * PhotoBig.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                    PhotoBigNext.transform = .identity
                })

                propertyAnimator.addCompletion { [self] position in
                    switch position {
                    case .end:
                        PhotoBig.image = newPhoto
                        PhotoBig.transform = .identity
                        //PhotoBigNext.image = nil
                        selectedPhotoIndex = newPhotoIndex
                    case .start:
                        PhotoBigNext.transform = CGAffineTransform(translationX: PhotoBigNext.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                    case .current:
                        break
                    @unknown default:
                        break
                    }
                }
            }
            
            
            
        case .changed:
            switch animationDirection {
            case .right:
                let percent = min(max(0, panGestureRec.translation(in: view).x / 200), 1)
                propertyAnimator.fractionComplete = percent
            case .left:
                let percent = min(max(0, -panGestureRec.translation(in: view).x / 200), 1)
                propertyAnimator.fractionComplete = percent
            }
  
        case .ended:
            if propertyAnimator.fractionComplete > 0.5 {
                propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            } else {
                propertyAnimator.isReversed = true
                propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            }
            
        default:
            break
        }
    }
    
    
    //MARK: - Свайп налево
    @objc func swipeInLeft() {

        guard selectedPhotoIndex < photos.count - 1 else { return }
        
        let newPhotoIndex = selectedPhotoIndex + 1
        let newPhoto = photos[newPhotoIndex].image
        
        PhotoBigNext.image = newPhoto
        PhotoBigNext.transform = CGAffineTransform(translationX: 1.35 * self.view.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
        
        UIView.animate(withDuration: 0.7) { [self] in
            PhotoBig.transform = CGAffineTransform(translationX: -1.35 * self.view.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            PhotoBigNext.transform = .identity
        } completion: { [self] _ in
            PhotoBig.image = newPhoto
            selectedPhotoIndex = newPhotoIndex
            PhotoBig.transform = .identity
            PhotoBigNext.transform = .identity
            // обнуляем фото, чтобы в случае чего оно не появилось за основным
            PhotoBigNext.image = nil
        }
    }

    
    //MARK: - Свайп направо
    @objc func swipeInRight() {

        guard selectedPhotoIndex >= 1 else { return }
        
        let newPhotoIndex = selectedPhotoIndex - 1
        let newPhoto = photos[newPhotoIndex].image
        
        PhotoBigNext.image = newPhoto
        PhotoBigNext.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
        
        UIView.animate(withDuration: 0.7) { [self] in
            PhotoBig.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
            PhotoBigNext.transform = .identity
        } completion: { [self] _ in
            PhotoBig.image = newPhoto
            selectedPhotoIndex = newPhotoIndex
            PhotoBig.transform = .identity
            PhotoBigNext.transform = .identity
            // обнуляем фото, чтобы в случае чего оно не появилось за основным
            PhotoBigNext.image = nil
        }
    }

    
    
//    //***
//    // MARK: - Animator
//    var interactiveAnimator: UIViewPropertyAnimator!
//
//    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
//
//        switch recognizer.state {
//        case .began:
//            interactiveAnimator?.startAnimation()
//            interactiveAnimator = UIViewPropertyAnimator(
//                duration: 0.5,
//                curve: .easeInOut,
//                animations: {
//                    self.PhotoBig.alpha = 0.5
//                    self.PhotoBig.transform = .init(scaleX: 1.4, y: 1.4)
//            })
//            interactiveAnimator.pauseAnimation()
//
//        case .changed:
//            let translation = recognizer.translation(in: self.view)
//            interactiveAnimator.fractionComplete = abs(translation.x / 100)
//            self.PhotoBig.transform = CGAffineTransform(translationX: translation.x, y: 0)
//
//        case .ended:
//            interactiveAnimator.stopAnimation(true)
//            if recognizer.translation(in: self.view).x < 0 { // проверка в какую сторону движется палец (лево/право)
//                if  selectedPhotoIndex < photos.count - 1  { // проверка, что фотка будет в массиве и не делать счетчик больше
//                    self.selectedPhotoIndex += 1
//                }
//            } else {
//                if selectedPhotoIndex != 0 {  // проверка, что фотка будет в массиве и не делать счетчик меньше
//                    self.selectedPhotoIndex -= 1
//                }
//            }
//            interactiveAnimator.addAnimations {
//                self.PhotoBig.transform = .identity
//                self.PhotoBig.alpha = 1
//            }
//            interactiveAnimator?.startAnimation()
//
//        default: break
//        }
//        PhotoBig.image = photos[selectedPhotoIndex].image
//
//    }
//    //***
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
