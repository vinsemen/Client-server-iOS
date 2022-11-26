//
//  MyNavigationController.swift
//  VK
//
//  Created by Semen Vinnikov on 30.07.2022.
//

import UIKit

class MyNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    
    // использование обработчика свайпов - переход по свайпу (назад)
    let interactiveTransition = CustomInteractiveTransition()
    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}


extension MyNavigationController: UINavigationControllerDelegate {

    // переходы по тапам на кнопки/поля
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            //присвоить свойству объекта тот viewController, для которого хотим сделать интерактивный переход
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return animatorTwist90Pop()
        case .push:
            self.interactiveTransition.viewController = toVC
            return animatorTwist90Push()
        case .none:
            return nil
        @unknown default:
            return nil
        }
    }
}


// анимация перехода вперед через кнопку
class animatorTwist90Push: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // откуда переход (источник)
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        // куда переход (цель)
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        // контейнер (экран)
        let containerViewFrame = transitionContext.containerView.frame
        
        // размер и положение фрейма, где окажется источник после анимации (слева)
        let sourceViewFrame = CGRect(
            x: -containerViewFrame.height,
            y: 0,
            width: source.view.frame.height,
            height: source.view.frame.width
        )
        
        // фрейм, где окажется цель после анимации
        let destinationViewFrame = source.view.frame
        
        // добавить в контейнер цель
        transitionContext.containerView.addSubview(destination.view)
        
        // переворот вью цели на 90градусов
        destination.view.transform = CGAffineTransform(rotationAngle: -(.pi/2))
        
        //размер и положение фрейма цели перед анимацией (справа и повернут)
        destination.view.frame = CGRect(
            x: containerViewFrame.width,
            y: 0,
            width: source.view.frame.height,
            height: source.view.frame.width
        )
        
        //анимация
        UIView.animate(
            withDuration: duration,
            animations: {
                // переворот вью на 90градусов
                source.view.transform = CGAffineTransform(rotationAngle: .pi/2)
                // вывод из окна источника
                source.view.frame = sourceViewFrame
                // обратный поворот цели
                destination.view.transform = .identity
                // ввод в окно цели
                destination.view.frame = destinationViewFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}

// анимация возрата назад через кнопку
class animatorTwist90Pop: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // откуда переход (источник)
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        // куда переход (цель)
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        let containerViewFrame = transitionContext.containerView.frame //контейнер (экран)
        
        // размер и положение фрейма, где окажется источник после анимации (справа)
        let sourceViewFrame = CGRect(
            x: containerViewFrame.width,
            y: 0,
            width: source.view.frame.height,
            height: source.view.frame.width
        )
        
        // фрейм, где окажется цель после анимации
        let destinationViewFrame = source.view.frame
        
        // добавить в контейнер цель
        transitionContext.containerView.addSubview(destination.view)

//        transitionContext.containerView.addSubview(source.view) // добавить в контейнер источник (чтобы он был над целью)
//
//        destination.view.transform = CGAffineTransform(rotationAngle: .pi/2) // переворот вью цели на 90градусов
        
        //размер и положение фрейма цели перед анимацией (слева и повернут)
        destination.view.frame = CGRect(
            x: -containerViewFrame.height,
            y: 0,
            width: source.view.frame.height,
            height: source.view.frame.width
        )
        
        //анимация
        UIView.animate(
            withDuration: duration,
            animations: {
                // вывод из окна источника
                source.view.frame = sourceViewFrame
                // переворот вью на 90 градусов
                source.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
                
                // обратный поворот цели
                destination.view.transform = .identity
                // ввод в окно цели
                destination.view.frame = destinationViewFrame
                
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }

}

// обработка свайпа пальцем (перехода назад свайпом)
class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    // свойство, которое будет хранить UIViewController — экран, для которого будет выполняться интерактивный переход
    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(handleScreenEdgeGesture))
            
                recognizer.edges = [.left]
                viewController?.view.addGestureRecognizer(recognizer)
//            UIPanGestureRecognizer
            
            
        }
        
    }
    
    
    // обработка жеста свайпа
    var hasStarted: Bool = false
    var shouldFinish: Bool = false

    @objc func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.hasStarted = true
            self.viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            //let relativeTranslation = translation.x / (recognizer.view?.bounds.width ?? 1) //ломается анимашка с поворотом при свайпе, так как экран перевернут и ось Х это ось У
            let relativeTranslation = translation.y / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            
            self.shouldFinish = progress > 0.35

            self.update(progress)
        case .ended:
            self.hasStarted = false
            self.shouldFinish ? self.finish() : self.cancel()
        case .cancelled:
            self.hasStarted = false
            self.cancel()
        default: break
        }
    }
}

// аниматор крутит окна всегда вверх
//class animatorMoveUp: NSObject, UIViewControllerAnimatedTransitioning {
//    let duration = 1.0
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return duration
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        // надо бы проверять гуардами, так как может не быть этих контроллеров
//        let source = transitionContext.viewController(forKey: .from)! //откуда переход (источник)
//        let destination = transitionContext.viewController(forKey: .to)! //куда переход (цель)
//
//        let containerViewFrame = transitionContext.containerView.frame //контейнер (экран)
//
//        let sourceViewFrame = CGRect( //это размеры и положение фрейма где окажется источник после анимации (над контейнером)
//            x: 0,
//            y: -containerViewFrame.height,
//            width: source.view.frame.width,
//            height: source.view.frame.height
//        )
//
//        let destinationViewFrame = source.view.frame // это фрейм где окажется цель после анимации
//
//        transitionContext.containerView.addSubview(destination.view) // добавить в контейнер цель
//
//        destination.view.frame = CGRect( //это размеры и положение фрейма цели перед анимацией (под контейнером)
//            x: 0,
//            y: containerViewFrame.height,
//            width: source.view.frame.width,
//            height: source.view.frame.height
//        )
//
//        //анимация
//        UIView.animate(
//            withDuration: duration,
//            animations: {
//                source.view.frame = sourceViewFrame
//                destination.view.frame = destinationViewFrame
//        }) { finished in
//            //source.removeFromParent()  // удалить источник, но тогда некуда будет вернуться...
//            transitionContext.completeTransition(finished)
//        }
//    }

