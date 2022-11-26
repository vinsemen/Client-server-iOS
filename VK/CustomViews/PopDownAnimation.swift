//
//  PopDownAnimation.swift
//  VK
//
//  Created by Semen Vinnikov on 28.07.2022.
//

import UIKit

class TopDownAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animationDuration: TimeInterval = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceController = transitionContext.viewController(forKey: .from), let destinationController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        transitionContext.containerView.addSubview(destinationController.view)
        
        destinationController.view.frame = sourceController.view.frame.insetBy(dx: 0, dy: -sourceController.view.frame.height)
        
        UIView.animate(withDuration: animationDuration, animations: {
            destinationController.view.frame = sourceController.view.frame 
        }) { completed in
            transitionContext.completeTransition(completed)
        }
        
    }
    
}
